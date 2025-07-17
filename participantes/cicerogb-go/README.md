# Rinha de Backend 2025

## Tecnologias utilizadas
- **Linguagem:** Go
- **Armazenamento:** Redis
- **Balanceador:** Nginx
- **Orquestração:** Docker Compose

## Como rodar
1. Suba o docker-compose dos Payment Processors primeiro (conforme instruções do repositório oficial).
2. Depois, suba este compose:
   ```sh
   docker compose up --build
   ```
3. O backend ficará disponível na porta **9999**.


## Repositório
https://github.com/cicerogb/rinha-backend-2025
