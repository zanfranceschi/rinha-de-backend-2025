> Esta é uma versão com o circuit breaker ligado e outras mudanças
> que focam menos em performance e mais em estabilidade

# RINHEX

[@leorcvargas](https://github.com/leorcvargas)

- Sobre

  - Optei por fazer tudo dentro do ecossistema do Elixir/Erlang, tirando o load balancer
  - LB <-> HTTP API <-> Worker node -> Payment Processors
  - Juro que deixo um diagrama legal aqui em breve

- Tecnologias:
  - HAProxy ou Nginx (load balancer)
  - Elixir (linguagem)
  - ETS (storage engine)
  - Bandit + Plug (HTTP server)
  - libcluster (Inter node connection)
  - Finch (HTTP client)
