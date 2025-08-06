# Rinha de Backend 2025 — Rust

Implementação da Rinha de Backend 2025 utilizando:

- [Rust](https://www.rust-lang.org/) apenas a melhor linguagem de todas
- [Nginx](https://nginx.org/) load balancer
- [UDS](https://en.wikipedia.org/wiki/Unix_domain_socket) unix domain sockets para comunicação IPC (evitando a network stack, especialmente na rede bridge do docker)

---

## Arquitetura

```mermaid
---
config:
  layout: dagre
---
flowchart TD
    A[nginx] <-->|uds HTTP| B(api0)
    A[nginx] <-->|uds HTTP| C(api1)
    C <-->|uds bincode| D[Worker]
    B <-->|uds bincode| D[Worker]
```

## Executando o binário

Este projeto define um único binário que pode rodar em dois modos:

### Modo Worker

Responsável por armazenar os pagamentos localmente em memória Vec<T>.

```bash
cargo run --release -- -m worker
```

### Modo API

Responsável por receber as requisições encaminhadas pelo Nginx e enviar para o worker processar e consultar o worker para obter o summary.

```bash
cargo run --release -- -m api
```
