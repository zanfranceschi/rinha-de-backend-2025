# Rinha de Backend 2025

## Tecnologias utilizadas

- **Linguagem:** Bun e typescript
- **Armazenamento:**: Redis
- **Fila:** Redis
- **Balanceador:** Nginx
- **Orquestração:** Docker Compose

## Como rodar

1. Suba os _Payment Processors_ com as instruções do repositório oficial.
2. Construa e suba o backend desenvolvido
   ```sh
   docker-compose up --build
   ```
3. O backend ficará disponível na porta **9999**, conforme as especificações do desafio.

## Sobre a solução

O backend foi desenvolvido em typescript com Elysia e bun. As requisições recebidas são enviado para uma fila no redis onde um worker é responsável por ler e encaminha para um processador que define qual payment processor vai ser usado no momento. Após o processamento, os pagamentos são armazenados em um conjunto ordenado no Redis.

## Repositório do código-fonte

[Rinha de backend 2025 Bun](https://github.com/LhuizF/rinha-de-backend-2025-bun)
