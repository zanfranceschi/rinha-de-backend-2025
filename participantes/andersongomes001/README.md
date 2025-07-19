# 🦀 Rinha de Backend 2025 - Rust

Este repositório contém a minha participação na **Rinha de Backend 2025**, implementada em **Rust**.

## 🚀 Tecnologias Utilizadas

- [Rust](https://www.rust-lang.org/)
- [Axum 0.8](https://docs.rs/axum) — Web framework moderno, baseado em Tokio
- [Tokio 1.46](https://tokio.rs/) — Runtime assíncrono de alta performance
- [Serde](https://serde.rs/) — Serialização/deserialização eficiente de JSON
- [Reqwest](https://docs.rs/reqwest) — Cliente HTTP assíncrono
- [Redis 0.32](https://docs.rs/redis) — Gerenciamento de cache, fila de transações, etc
- [Chrono](https://docs.rs/chrono) — Manipulação de datas e horários

## 📁 Estrutura do Projeto

```text
rinha-2025/
├── build-and-push.sh        # Script para build e push da imagem Docker
├── Cargo.lock
├── Cargo.toml               # Dependências e metadados do projeto Rust
├── docker-compose.yml       # Orquestração da API, worker, Redis e Nginx
├── Dockerfile               # Dockerfile principal da API
├── Dockerfile.worker        # Dockerfile específico do worker
├── nginx.conf               # Configuração do Nginx para load balancing
├── README.md                # Este arquivo :)
└── src/
    ├── bin/
    │   └── worker.rs        # Binário separado para o worker (Incompleto)
    ├── lib.rs               # Módulos compartilhados entre API e worker
    └── main.rs              # Ponto de entrada da API
```

## 🚀 Como rodar

Certifique-se de ter o **Docker** e o **Docker Compose** instalados.

```bash
git clone https://github.com/andersongomes001/rinha-2025.git
cd rinha-2025
docker compose up --build
```
