# Rinha de Backend 2025

## Tecnologias utilizadas
- **Linguagem:** Java
- **Framework:** Spring Boot 3
- **Armazenamento:** Redis
- **Load Balancer:** Nginx/OpenResty
- **Orquestração:** Docker Compose
- **Outros:** Lua

## Como rodar
1. Suba o docker-compose dos Payment Processors primeiro (conforme instruções do repositório oficial).
2. Depois, suba este compose:
   ```sh
   docker compose up --build
   ```
3. O backend ficará disponível na porta **9999**.

## Sobre a solução
O backend foi desenvolvido em Java, utilizando Spring Boot 3 e compilado com GraalVM... (continua em breve).

## Repositório
[https://github.com/lecosas/rinha-backend-2025-java](https://github.com/lecosas/rinha-backend-2025-java)