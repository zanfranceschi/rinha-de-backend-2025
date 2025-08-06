# Rinha de Backend 2025 - Submissão

## Tecnologias

- **Linguagem:** Go
- **Cache/Fila:** Go in-memory
- **Balanceador:** HAProxy
- **Orquestração:** Docker Compose

## Como rodar

1. Suba o docker-compose dos Payment Processors primeiro (conforme instruções do repositório oficial).
2. Depois, suba este compose:
   ```sh
   docker compose up --build
   ```
3. O backend ficará disponível na porta **9999**.

## Sobre

O backend foi desenvolvido em Go, processando pagamentos de forma assíncrona com cache e fila em go. O sistema de filas e cache utiliza RPC para receber requisições. O Nginx faz o balanceamento entre as instâncias. O healthcheck dos processadores é realizado de 5 em 5s.

## Código-fonte

[https://github.com/niltonkummer/rinha-backend-2025](https://github.com/niltonkummer/rinha-backend-2025)