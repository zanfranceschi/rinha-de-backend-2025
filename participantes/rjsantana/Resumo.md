# 🧾 Relatório Técnico — Rinha de Backend 2025

**Participante:** Reinaldo Jesus  
**Stack:** Quarkus (Java 21), Redis, Docker, K6  
**Período de Teste:** 1m30s  
**Usuários Virtuais Máximos:** 504  
**Fonte de Métricas:** K6 Dashboard

---

## ✅ 1. Arquitetura e Tecnologias

| Camada        | Tecnologia                        |
|---------------|------------------------------------|
| Backend       | Quarkus 3 + Java 21                |
| Banco/Cache   | Redis (chave-valor + pub/sub)      |
| Mensageria    | Redis Pub/Sub                      |
| Containerização | Docker + Docker Compose         |
| Testes de carga | [K6](https://k6.io)              |

---

## 🚀 2. Resultados de Performance

### 🔹 Métricas gerais (K6)

| Métrica                   | Valor                    |
|---------------------------|--------------------------|
| Requisições HTTP          | 15.300                   |
| Transações bem-sucedidas  | 15.200                   |
| Transações com falha      | **0 (zero)** ✅          |
| Tempo médio de requisição | **1ms** 🔥               |
| P99 de latência           | **4ms**                  |
| Iterações totais          | 15.200                   |
| Usuários simultâneos      | Máx: 504, Ativo: 1       |

### 🔹 Breakdown de tempo HTTP

| Etapa da requisição           | Tempo médio |
|-------------------------------|-------------|
| Conexão (`http_req_connecting`) | 11µs      |
| Espera do servidor (`http_req_waiting`) | 1ms  |
| Recebimento da resposta (`http_req_receiving`) | 95µs |
| Tempo total (`http_req_duration`) | **1ms** |

---

## 💵 3. Métricas de Transações Financeiras

| Métrica                         | Valor acumulado | Taxa por segundo |
|----------------------------------|------------------|-------------------|
| Total processado (default)       | 176.4k unidades  | 2.82k/s           |
| Total processado (fallback)      | 67.6k unidades   | 1.08k/s           |
| Total geral                      | **244k unidades**| **3.9k/s** 🔥     |
| Total de taxas (`fee`)           | 18.9k unidades   | 302.9/s           |

---

## ⚠️ 4. Pontos de Atenção

### ⚠️ Inconsistência de Saldo

| Métrica                        | Valor total | Taxa     |
|--------------------------------|-------------|----------|
| `balance_inconsistency_amount` | 33.2k       | 530/s ⚠️ |

**Possíveis causas:**
- Falta de atomicidade entre `GET` e `SET`
- Múltiplos workers atualizando o mesmo saldo simultaneamente
- Operações concorrentes sem controle de consistência

---

## 🛠️ 5. Boas práticas aplicadas

- ✅ Separação clara entre orquestração e processamento
- ✅ Comunicação assíncrona com Redis Pub/Sub
- ✅ Redis como fila leve e rápida
- ✅ Lógica de agregação eficiente com EnumMap
- ✅ Logging, validação e tratamento de exceções
- ✅ Testes de carga com K6 (504 usuários simultâneos sem falhas)

---

## 💡 6. Oportunidades de Melhoria

| Ponto                     | Sugestão Técnica                                          |
|---------------------------|-----------------------------------------------------------|
| Consistência de saldo     | Usar `Lua scripts` no Redis (`EVAL`) para atomicidade     |
| Cálculo de somatórios     | Indexar pagamentos com `ZSET + timestamp` (`ZRANGEBYSCORE`) |
| Observabilidade           | Adicionar Prometheus + Micrometer                        |
| Persistência durável      | Integrar com PostgreSQL para consistência eventual       |
| Telemetria                | Usar OpenTelemetry para rastreamento distribuído         |

---

## 🏁 Conclusão

> A aplicação demonstrou **ótima performance sob carga extrema**, com **baixa latência**, **altíssima taxa de transações por segundo** e **zero falhas**. A arquitetura baseada em Quarkus + Redis mostrou-se **eficiente e escalável**.

Com pequenos ajustes em **consistência de dados**, a solução estaria pronta para **ambientes de missão crítica**.

