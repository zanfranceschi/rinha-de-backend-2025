# Kauan GO

Implementação da Rinha de Backend 2025 utilizando **Go** com `fasthttp`, Redis e workers assíncronos.  
Repositório do projeto: [github.com/KauanCarvalho/rinha-de-backend-2025-go](https://github.com/KauanCarvalho/rinha-de-backend-2025-go)

---

## ⚙️ Tecnologias Utilizadas

- **Linguagem**: Go 1.24.5
- **Servidor HTTP**: [fasthttp](https://github.com/valyala/fasthttp)
- **Persistência**: Redis (Lista para fila + Hash para resultados)
- **Orquestração**: Docker + Docker Compose
- **Balanceamento**: NGINX

---

## Fluxo do Sistema

1. **Requisições HTTP** chegam ao NGINX, que distribui entre dois containers `api` em Go com `fasthttp`.
2. O payload do pagamento é validado e enfileirado no Redis via `LPUSH`.
3. Um **worker** consome a fila (`payments_created`) e processa os pagamentos.
4. O processamento envolve uma chamada HTTP ao `payment processor` (default ou fallback), com seleção dinâmica baseada em healthcheck.
5. O resultado é salvo em Redis (`HSET payments`), e pode ser consultado depois via `/payments-summary`.

---

## Estratégias de Desempenho

- **API com `fasthttp`** para máxima performance.
- **Paralelismo controlado** via pool de workers.
- **Retry automático**: falhas no processamento são re-enfileiradas.
- **Locks Redis (`SET NX`)** para healthcheck distribuído e throttle de seleção de processador.
- **Resumo (`/payments-summary`)** com streaming dos valores para evitar OOM.

---

## 📦 Endpoints

| Método | Rota                | Descrição                          |
|--------|---------------------|------------------------------------|
| POST   | `/payments`         | Cria um novo pagamento             |
| GET    | `/payments-summary` | Consulta totais por processador    |
| POST   | `/purge-payments`   | Limpa Redis (fila + hash)          |
| GET    | `/healthcheck`      | Verifica se a aplicação está OK    |
