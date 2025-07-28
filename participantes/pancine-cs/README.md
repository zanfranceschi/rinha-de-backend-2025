# Descrição
Link para o repositório: https://github.com/pancine/rinha-de-backend-2025-purchase-gateway

Em resumo, ao receber uma requisição de pagamento, a API coloca a requisição em uma fila através da funcionalidade nativa Channel.

Um número `x` de workers (PURHCASE_WORKERS no docker compose) rodando no background puxam mensagens dessa fila e processam o pagamento e logo em seguida enviam para o banco de forma assíncrona.

## Tecnologias utilizadas
- Redis
- .NET
- PostgreSQL

