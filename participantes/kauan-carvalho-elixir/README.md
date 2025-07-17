# Kauan Elixir

Implementação da Rinha de Backend 2025 utilizando **Elixir** com `Phoenix`, `Broadway` e Redis para processamento assíncrono.  
Repositório do projeto: [github.com/KauanCarvalho/rinha-de-backend-2025-elixir](https://github.com/KauanCarvalho/rinha-de-backend-2025-elixir)

---

## ⚙️ Tecnologias Utilizadas

- **Linguagem**: Elixir 1.18 + Erlang/OTP 28
- **Framework Web**: [Phoenix](https://www.phoenixframework.org/)
- **Processamento Assíncrono**: [Broadway](https://hexdocs.pm/broadway), com `GenStage`
- **Cliente Redis**: [Redix](https://hexdocs.pm/redix)
- **Orquestração**: Docker + Docker Compose
- **Balanceamento**: NGINX
- **HTTP Client**: Finch
- **Servidor**: Bandit

---

## ⚙️ Fluxo do Sistema

1. **Requisições HTTP** chegam ao NGINX, que distribui para múltiplos containers Phoenix.
2. O payload do pagamento é validado e enfileirado no Redis via `LPUSH`.
3. Um **Broadway pipeline** consome a fila (`payments_created`) usando `GenStage` personalizado.
4. Cada item é processado chamando o `payment processor` (`default` ou `fallback`), selecionado dinamicamente por healthcheck.
5. O resultado é salvo no Redis (`HSET payments`) e pode ser consultado depois via `/payments-summary`.

---

## 🧠 Estratégias de Desempenho

- **Concurrent processing** com `Broadway` e configuração de `max_demand`.
- **Failover automático**: re-enfileiramento em caso de erro.
- **Locks com Redis (`SET NX`)** para healthcheck distribuído e throttle.
- **Resumo otimizado**: cálculo de métricas em tempo real via Redis Hash sem sobrecarga.

---

## 📦 Endpoints

| Método | Rota                | Descrição                          |
|--------|---------------------|------------------------------------|
| POST   | `/payments`         | Cria um novo pagamento             |
| GET    | `/payments-summary` | Consulta totais por processador    |
| POST   | `/purge-payments`   | Limpa Redis (fila + hash)          |
| GET    | `/healthcheck`      | Verifica se a aplicação está OK    |
