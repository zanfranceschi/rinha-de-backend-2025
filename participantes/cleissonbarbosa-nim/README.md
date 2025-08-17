# Rinha de Backend 2025 — Nim

Implementação da Rinha de Backend 2025 utilizando:

- [Nim](https://nim-lang.org/) linguagem de programação
- [UDS](https://en.wikipedia.org/wiki/Unix_domain_socket) unix domain sockets para comunicação IPC (evitando a network stack, especialmente na rede bridge do docker)

---

## Arquitetura

```mermaid
---
config:
  layout: dagre
---
flowchart TD
    A[load balancer] <-->|uds HTTP| B(api0)
    A[load balancer] <-->|uds HTTP| C(api1)
    C <-->|uds bincode| D[worker]
    B <-->|uds bincode| D[worker]
```

## Executando o binário

Este projeto define um único binário que pode rodar em três modos:

### Modo Load balancer

Responsável por fazer a conexão e balanceamento das chamadas HTTP para unix sockets entre o client e e as instâncias de API.

```bash
nimble run rinha -- -m lb
```

### Modo API

Responsável por receber as requisições encaminhadas pelo Nginx e enviar para o worker processar e consultar o worker para obter o summary.

```bash
nimble run rinha -- -m api
```

### Modo Worker

Responsável por armazenar os pagamentos localmente em memória seq[Payment].

```bash
nimble run rinha -- -m worker
```
