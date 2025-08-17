# Backend Contest 2025 (rinha de backend) – Go
Payment processors orchestration through retry middleware using exponential backoff.

## Technologies

- **Go** (with intensive use of **goroutines** for concurrency and parallelism)
- **Nginx** (reverse proxy and load balancing)
- **Docker** (containerization and service isolation)
- **Redis** (asynchronous processing queue)
- **Postgres** (data persistence)

## Architecture

- **Hexagonal Architecture (Ports & Adapters)**: keeps business logic independent of frameworks and infrastructure.
- **Retry Middleware with Exponential Backoff**: ensures resilience when calling external payment processors.

## Repositório

[GitHub](https://github.com/filipebafica/rinha-backend-2025)