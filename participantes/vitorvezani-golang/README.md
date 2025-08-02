# Rinha de Backend 2025 - Submissão

## Autor: Vitor Vezani

## Tecnologias utilizadas
- **Linguagem:** Go
- **Armazenamento:** redis
- **Orquestração:** Docker Compose
- **Load Balancer:** Nginx

## Como rodar
1. Suba o docker-compose dos Payment Processors primeiro (conforme instruções do repositório oficial).
2. Depois, suba este compose:
   ```sh
   docker compose up --build
   ```
3. O backend ficará disponível na porta **9999**.

## Sobre a solução
Solução simples sync (sem tempo irmão), se tiver um tempo livre pretendo expandir para suportar alto volume de transações, estratégias de retry, fallback e recuperação automática e filas.

## Contato
- **GitHub:** [@vitorvezani](https://github.com/vitorvezani)
