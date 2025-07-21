# 🏁 Rinha de Backend 2025 – Elixir

Solução em **Elixir + BEAM** para o desafio da Rinha de Backend 2025, com foco extremo em **baixa latência**, **consistência** e **simplicidade arquitetural**.

## 🔧 Estratégia

- Subimos **um único processo global** que recebe requisições assíncronas via `GenServer.cast/2`.
- Toda a lógica de negócio roda **em memória**, sem persistência.
- A **comunicação entre os containers** é feita usando a **distribuição nativa da BEAM (Erlang Distribution)**.
- Balanceamento feito por **NGINX**, minimamente configurado para reduzir overhead.
- Escolha dinâmica entre **default** e **fallback** de acordo com custo (tempo + taxa).
- Transações de alto valor são reprocessadas se o default estiver fora.

## 🧠 Arquitetura

```mermaid

graph TD
  subgraph Clients
    C1[Load Tester / Client API]
  end

  subgraph Proxy
    NGINX[NGINX]
  end

  subgraph Elixir Nodes
    APP1[app1]
    APP2[app2]
  end

  subgraph External
    DEF[Default Processor]
    FBACK[Fallback Processor]
  end

  C1 --> NGINX --> APP1
  C1 --> NGINX --> APP2

  APP1 <--> APP2

  APP1 --> DEF
  APP1 --> FBACK
  APP2 --> DEF
  APP2 --> FBACK

