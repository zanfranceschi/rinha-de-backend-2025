## Rinha de Backend 2025 - .NET 9 AOT

High-performance payment processing system built with .NET 9 and AOT compilation.

## 🔧 Tech Stack

- **.NET 9** with **AOT compilation** for faster startup and lower memory usage
- **Minimal APIs** for lightweight HTTP endpoints
- **PostgreSQL** for payments persistence
- **Redis** for distributed health caching
- **Nginx** for load balancing

## 🚀 Quick Start

```bash
# Start payment processors first and then:
docker-compose up --build

# Test
curl -X POST http://localhost:9999/payments \
  -H "Content-Type: application/json" \
  -d '{"correlationId": "123e4567-e89b-12d3-a456-426614174000", "amount": 19.9}'

curl http://localhost:9999/payments-summary
```

Built for **[Rinha de Backend 2025](https://github.com/zanfranceschi/rinha-de-backend-2025)** 🐔