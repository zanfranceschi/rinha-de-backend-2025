# Submissão Rinha de Backend 2025 - Vitor Vale

Esta pasta contém os arquivos necessários para execução da minha submissão no desafio Rinha de Backend 2025.

## Tecnologias utilizadas

- **Node.js** com **NestJS** como framework principal
- **PostgreSQL** como banco de dados relacional
- **Redis** como mecanismo de filas com BullMQ
- **BullMQ** para controle de tarefas assíncronas e processamento em background
- **Nginx** atuando como balanceador de carga entre as instâncias da API

## Execução

Para iniciar os serviços, basta rodar:

```bash
docker-compose up -d