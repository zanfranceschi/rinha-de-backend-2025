# 🥊 Rinha de Backend 2025

![Build](https://img.shields.io/badge/status-ready-brightgreen)  
![Redis](https://img.shields.io/badge/cache-redis-red)
![Nginx](https://img.shields.io/badge/load--balancer-nginx-lightgrey)

## 🔥 Sobre o projeto
Submissão para a **Rinha de Backend 2025**, construída com foco em **alta performance**, **resiliência com fallback**, **retries inteligentes**, e **consistência de saldo garantida** sob carga.

O projeto foi implementado com a linguagem **Go**, usando um único binário super otimizado, dividido em múltiplos arquivos seguindo boas práticas de organização. Utiliza **Redis** como cache para idempotência e healthcheck, com balanceamento via **NGINX** e estratégia de retry reativa entre processadores.

---

## 🚀 Tecnologias utilizadas

| Categoria        | Tecnologias             |
|------------------|--------------------------|
| Linguagem        | Go 1.21+                 |
| Armazenamento    | Redis                    |
| Balanceador      | NGINX                    |
| Outras           | Fiber (web framework), Sonic (JSON parser ultra-rápido), Docker, Docker Compose |

---

## 📦 Repositório com código fonte

➡️ [https://github.com/joelgarciajr84/rinha-backend-go](https://github.com/joelgarciajr84/rinha-backend-go)

---

## 🐳 Como rodar

Clone este repositório e execute:

```bash
docker compose up --build -d
```