# Resumo

Repositório: https://github.com/jotaviobiondo/rinha-backend-2025

## Tecnologia e arquitetura
A aplicação é construída usando:

- **Elixir** - Linguagem principal usada no projeto.
- **Bandit** - Servidor HTTP para lidar com requisições da API.
- **Redis** - Usado tanto como banco de dados para armazenar dados de pagamento quanto como fila de mensagens para processamento assíncrono.
- **Broadway** - Pipeline de ingestão de dados que consome jobs de pagamento da fila Redis e os processa.
- **HAProxy** - Balanceador de carga para distribuir requisições entre instâncias da aplicação.
- **Persistent term do Erlang**: Para cache das informações de healthcheck dos processadores de pagamento.

Queria manter a arquitetura bem simples, mas também próxima do uso no mundo real.

Quando um pagamento é recebido, ele é enfileirado usando uma lista Redis e então processado assincronamente pelo Broadway.
No Broadway, tentamos processar o pagamento usando o processador de pagamento com a melhor taxa e disponibilidade (confira [processor_selector.ex](https://github.com/jotaviobiondo/rinha-backend-2025/blob/main/lib/payment_gateway/payments/processor_selector.ex) para ver como essa "disponibilidade" é implementada).
Se falhar, reenfileiramos o pagamento para nova tentativa.
Se tiver sucesso, armazenamos em um Redis Sorted Set usado como "armazenamento de longo prazo".

Algumas outras melhorias para melhor performance:
- **Unix Domain Sockets (UDS)**: Em vez de comunicação HTTP regular, sockets de domínio unix foram usados para o balanceador de carga (haproxy) se comunicar com as instâncias da aplicação. UDS também foram usados para comunicação com o Redis.
- **Pool de Conexões Redis**: Um pool simples de conexões foi implementado para ter melhor suporte a alta carga.
- **Cluster do Erlang**: As instâncias da aplicação são conectadas como cluster para manter o Cache sincronizado entre os nós.
