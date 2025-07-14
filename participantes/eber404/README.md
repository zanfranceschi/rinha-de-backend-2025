# DudeBank - Payment Processing System

Sistema de intermediação de pagamentos desenvolvido para a **Rinha de Backend 2025** 🐔 🚀

Repositório: https://github.com/eber404/dudebank

## 🏗️ Stack / Arquitetura

- Bun / TS
- PostgresSQL + Redis
- Nginx 

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Nginx     │───▶│   API 1     │───▶│ PostgreSQL  │
│Load Balancer│    │   API 2     │    │  Database   │
└─────────────┘    └─────────────┘    └─────────────┘
                          │
                          ▼
                   ┌─────────────┐
                   │    Redis    │
                   │    Cache    │
                   └─────────────┘
```