# DudeBank - Payment Processing System

Sistema de intermediação de pagamentos desenvolvido para a **Rinha de Backend 2025** 🐔 🚀

Repositório: https://github.com/eber404/dudebank

## 🏗️ Stack / Arquitetura

- Bun
- Nginx Load Balancer

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Nginx     │───▶│   API 1     │───▶│   Memory    │
│Load Balancer│    │   API 2     │    │  Database   │
│ (least_conn)│    │ (3001/3002) │    │ (MemoryDB)  │
└─────────────┘    └─────────────┘    └─────────────┘
                          │
                          ▼
                   ┌─────────────┐
                   │Payment Queue│
                   │(In-Memory)  │
                   └─────────────┘
```
