# Rinha Backend 2025 - Submissão Node.js

---

## Tecnologias Utilizadas

- **Linguagens:** TypeScript, JavaScript 
- **Backend:** Fastify, BullMQ
- **Cache e filas:** Redis (Redis Streams)
- **HTTP Client:** Undici
- **Runtime:** Node.js
- **Orquestração e proxy:** Docker Compose, Nginx

---

## Arquitetura

O sistema é composto por múltiplos serviços distribuídos:

- **Nginx** – Proxy reverso, balanceando carga entre as APIs.
- **API1 e API2** – Serviços Node.js para processamento de requisições:
  - Recebem requests dos clientes e encaminham para o processamento de pagamento.
  - Threadpool configurado com `UV_THREADPOOL_SIZE=64`.
  - Limites de CPU/memória definidos para simular ambiente de produção.
- **Worker Job** – Worker dedicado para processar filas:
  - Usa **BullMQ + Redis Streams** para gerenciar tasks com prioridade e fallback inteligente.
  - Processa os jobs de pagamento de forma distribuída e resiliente.
- **Redis** – Armazena as filas de pagamento, controla estado dos jobs e cache.

Os serviços **API1, API2 e Worker** estão conectados a duas redes:  
- `rinha-net` (rede interna para comunicação entre serviços)  
- `payment-processor-net` (rede externa compartilhada com o processador de pagamentos)

---

## Como Rodar

```bash
git clone https://github.com/Eduardofp17/rinha-backend-2025.git
cd rinha-backend-2025
pnpm install
docker compose up
```

---
## Link do Repositório

[clique aqui](https://github.com/Eduardofp17/rinha-backend-2025)