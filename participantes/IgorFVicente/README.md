# Rinha de Backend 2025 - Submissão Go

## Tecnologias utilizadas

- **Linguagem:** Go
- **Balanceador:** Nginx
- **Orquestração:** Docker Compose, Docker
- **Armazenamento:** Redis
- **Fila:** Redis

## Como rodar

1. Iniciar os processadores através do docker-compose do repositório da rinha
2. Iniciar os containers do projeto através do comando docker-compose up -d
3. Após a conclusão, o nginx deve estar disponível na porta 9999 do localhost e distribuindo as requisições para os containers api-1 e api-2

## Sobre a solução

O projeto cria um servidor utilizando fasthttp e servindo as rotas necessárias (/payments, /payments-summary e /purge-payments).

Uma instância do Nginx faz o load balancing entre duas instâncias idênticas executando o servidor.

Uma instância de Redis é utilizada tanto para gerenciar um serviço de fila quanto para armazenar os registros de pagamentos realizados.

O processo ocorre da seguinte forma:

- Ao iniciar a aplicação, são criados workers que devem ouvir e executar os jobs que forem adicionados à fila do redis.
- Também ao iniciar a aplicação é iniciado um "HealthChecker" que, a cada 5 segundos, valida o funcionamento do processador "fallback" e salva em cache o seu status.
- Ao receber um pedido de pagamento (/payments) o servidor inicia uma goroutine que enviará os dados desse pedido para a fila e prontamente responde com um status 202 (Accepted), buscando o menor tempo de resposta possível.
- Os workers iniciados anteriormente executam constantemente os jobs presentes na fila, seguindo esta lógica:
  - Tenta processar através do "default".
  - Caso esteja indisponível e o fallback esteja disponível, processa através do fallback.
  - Caso ambos estejam indisponíveis, retorna o job para a fila para ser processado posteriormente.
- Sempre que um pagamento é processado com sucesso, ele é adicionado ao redis, dessa vez atuando como um serviço de armazenamento.

Considerando os resultados obtidos, acredito que os próximos passos seriam:

- Investigar formas de diminuir o tempo de resposta das requests - Mesmo com o retorno praticamente imediato ainda não consegui resultados menores do que 5ms
- Elaborar uma melhor utilização do processador "default" - Mesmo com a priorização realizada pelos workers ainda há uma fatia considerável de pagamentos sendo processados através do fallback.

Este é meu primeiro projeto em Go, excetuando projetos "code along", e por ainda ser uma linguagem com a qual não estou acostumado a solução veio a base de muito Claude + tentativa e erro 😁

## Repositório

[https://github.com/IgorFVicente/rinha-go/](https://github.com/IgorFVicente/rinha-go/)
