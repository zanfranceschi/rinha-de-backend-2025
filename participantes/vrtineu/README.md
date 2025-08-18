# Rinha de Backend 2025

## Tecnologias

- **Linguagem**: Go 1.24
- **Load Balancer**: HAProxy
- **Cache/Queue**: Redis (Streams + Sorted Sets)
- **Containerização**: Docker Compose

## Arquitetura

- 2 instâncias da aplicação com HAProxy
- Processamento assíncrono via Redis Streams
- Workers dinâmicos (2-8 baseado em CPU)
- Health monitoring dos payment processors

---

**Repositório**: [GitHub](https://github.com/vrtineu/payments-proxy)