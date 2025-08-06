# Rinha Backend 2025 - Gustavo Miranda

## Descrição

Projeto desenvolvido em C# com ASP.NET Core 9.0, utilizando AOT (Ahead-of-Time compilation) para otimização de desempenho e startup mais rápido. Persistência de dados é feita com o Dapper, proporcionando consultas SQL de alta performance com baixo overhead.

Repositório do projeto: [link](https://github.com/gustmrg/rinha-backend-2025)

## Tecnologias

- C# / ASP.NET Core
- PostgreSQL
- NGINX
- Redis
- Docker

## Recursos de cada componente

| Container | Imagem                            | CPUs | Memória | Detalhes       |
| --------- | --------------------------------- | ---- | ------- | -------------- |
| api01     | gustmrg/rinha-backend-2025:latest | 0.50 | 85MB    | API instance 1 |
| api02     | gustmrg/rinha-backend-2025:latest | 0.50 | 85MB    | API instance 2 |
| db        | postgres:17-alpine                | 0.30 | 110MB   | Database       |
| redis     | redis:7.4-alpine                  | 0.12 | 60MB    | Cache          |
| nginx     | nginx:1.27.0-alpine               | 0.08 | 10MB    | Load balancer  |
| **TOTAL** |                                   | 1.5  | 350MB   | -              |
