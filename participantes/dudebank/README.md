# DudeBank - Payment Processing System

Sistema de intermediação de pagamentos desenvolvido para a **Rinha de Backend 2025** 🐔 🚀

Repositório: https://github.com/eber404/dudebank

## 🏗️ Stack / Arquitetura

- Bun / TypeScript
- SQLite (persistente)
- Nginx Load Balancer

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Nginx     │───▶│   API 1     │───▶│   SQLite    │
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

## 🎯 Estratégia

### Failover Inteligente
- **Processador Ótimo**: Prioriza o processador `default` (menor taxa) mas monitora continuamente o `fallback`
- **Health Check Distribuído**: Apenas uma instância de API executa health checks para evitar Rate Limiting (HTTP 429)
- **Decisão Dinâmica**: Troca para `fallback` apenas quando há vantagem significativa de velocidade (>11.76% mais rápido)
- **Retry com Fallback**: Se o processador primário falha, tenta o alternativo automaticamente
- **Race Condition**: Em caso de falha total, executa requisições paralelas para ambos os processadores até um deles responder

### Otimizações de Performance
- **Processamento em Lote**: Processa pagamentos em batches de 100 itens a cada 5ms
- **Queue Thread-Safe**: Utiliza `Map<string, PaymentRequest>` para evitar duplicatas e race conditions
- **SQLite Otimizado**: Transações em lote com índices para performance (requested_at, processor)
- **Timeouts Configuráveis**: 
  - Payment processors: 1s
  - Health checks: 5s
  - Race conditions: 10s
- **Async Locking**: Sistema de locks com fila para coordenar acesso concorrente ao banco
