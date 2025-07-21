# Rinha de Backend 2025 - Matheus do Java

Solução em Java 21 usando Spring Boot com suporte a Threads Virtuais (Project Loom) para máxima concorrência com simplicidade de código.

## 🧱 Tecnologias

- Java 21 (com Loom)
- Spring Boot
- MongoDB
- Feign
- Nginx (balanceamento)

## 🚀 Estratégia

- Threads virtuais ativadas para suportar alta concorrência mesmo com Feign bloqueante.
- Balanceamento entre instâncias usando Nginx.

## 🐳 Como rodar

```bash
docker-compose up --build
