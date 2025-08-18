# Rinha Vanilla 2025 🥩

Gateway de pagamentos resiliente construído em **Elixir**, usando **Broadway, Redis, Finch e Nginx**.  
Focado em **alta concorrência, filas inteligentes e failover automático** entre processadores.

---

## ⚡ Principais ideias
- **Filas no Redis**  
  - `Sorted Set` para pagamentos comuns (ordenados por valor).  
  - `List` para pagamentos de alto valor.  

- **Pipelines em paralelo (Broadway)**  
  - `StandardPayment.Pipeline` → pagamentos comuns.  
  - `HighPayment.Pipeline` → valores altos.  

- **Threshold dinâmico** (percentil 80) define automaticamente o que é “alto valor”.  
- **Failover automático** entre processadores `default` e `fallback` com base em **health checks**.  
- **Nginx** na frente, balanceando requisições (`least_conn`, keepalive).  

---

## 🛠️ Tecnologias
- Elixir + Broadway  
- Redis (Redix)  
- Finch (HTTP)  
- Bandit + Plug.Router  
- Nginx  

---

## 📡 Endpoints principais
- `POST /payments` → cria pagamento.  
- `GET /payments-summary` → resumo por processador e período.  
- `POST /purge-payments` → limpa dados.  
- `GET /health` → status do gateway.  

---

## 📊 Diagrama rápido

```mermaid
graph TD
  C[Cliente] --> N[Nginx LB]
  N --> G[(Gateway - Elixir<br/>Broadway)]
  G --> R[(Redis<br/>Queues & Cache)]
  G --> PD[Processador Default]
  G --> PF[Processador Fallback]
  PD -.Failover.-> PF
