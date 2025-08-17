# 🏁 Rinha de Backend 2025 Pro Max

> 🚀 Solução high-performance em **Go** para a Rinha de Backend 2025

## 🎯 O que é

Sistema de pagamentos distribuído com circuit breaker, processamento assíncrono e balanceamento de carga, otimizado para máxima performance e resiliência.

## ⚡ Features

- 🔄 **Circuit Breaker**: Proteção automática contra falhas
- 🧵 **Workers Assíncronos**: Processamento paralelo otimizado  
- 💾 **In-Memory Storage**: Armazenamento ultra-rápido
- 🔀 **Load Balancer**: HAProxy para distribuição de carga
- 🐳 **Docker Ready**: Deploy simplificado com containers

## 🛠️ Stack

- **Backend**: Go + Fiber
- **Proxy**: HAProxy
- **Infra**: Docker + Docker Compose
- **CI/CD**: GitHub Actions

## 🚀 Quick Start

```bash
# Clonar repositório
git clone https://github.com/jeiferson/rinha-backend-2025-pro-max

# Subir ambiente completo
docker-compose up -d

# Testar endpoint
curl -X POST http://localhost:9999/payments \
  -d '{"correlationId":"123","amount":100.0,"requestedAt":"2025-01-01T10:00:00Z"}'
```

<<<<<<< HEAD
---
=======
---
>>>>>>> 48e703e0712144a585b45873c0525a3ad85dcd43
