# Rinha de Backend 2025

## Tecnologias utilizadas

- **Linguagem:** C# e .NET9.0
- **Armazenamento:**: Postgres
- **Fila:** InMemory
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

O backend foi desenvolvido em .NET 9.0 usando Postgres para persistência de dados e uma fila em memória para o processamento dos pagamentos. O consumer escuta a fila e tenta
processar usando policy de retries no default e no fallback. Caso nenhum dos dois funcione a mensagem volta para a fila para processamento posterior.

## Repositório do código-fonte

[https://github.com/leandrobattochio/RinhaBackend2025](https://github.com/LhuizF/rinha-de-backend-2025-dotnet)
