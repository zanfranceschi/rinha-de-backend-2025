# Rinha de Backend 2025

## Stack
- **Go 1.23** + FastHTTP
- **PostgreSQL** + Redis
- **Nginx** (load balancer)

## Arquitetura
- 2 instâncias com worker pools assíncronos
- Health check com circuit breaker
- Persistência híbrida (memória + banco)

## Performance
- P99: 2.61ms @ 550 req/s
- Zero failed requests

## Repositório
https://github.com/steixeira93/rinha-backend-2025

---
Samuel Teixeira • [@steixeira93](https://github.com/steixeira93)
