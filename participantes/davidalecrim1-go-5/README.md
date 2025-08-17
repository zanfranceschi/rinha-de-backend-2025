# Rinha de Backend 2025 - Submissão

## Tecnologias utilizadas
- **Linguagem:** Go
- **Armazenamento/Fila:** Redis
- **Balanceador:** Extreme (Custom Made)
- **Orquestração:** Docker Compose

## Sobre a solução
Essa versão foi adaptada para:
- Usar Unix Sockets entre o Extreme (custom load balancer em Go) e as APIs de backend (4 instancias).
- A API salva os bytes numa fila do Redis.
- Um Worker processa as mensagens no endpoint do Processor Default caso esteja disponivel.
- Os retries voltam para a fila do Redis.
- A comunicação com Redis também está usando Unix Sockets.

## Repositório
[https://github.com/davidalecrim1/rinha-with-go-2025/tree/release/redis-fasthttp-extreme-v3](https://github.com/davidalecrim1/rinha-with-go-2025/tree/release/redis-fasthttp-extreme-v3)

[Repositório do Load balancer customizado](https://github.com/davidalecrim1/extreme). Ele NÃO realiza early return das requisições, apenas faz o reverse proxy para as instancias do backend.