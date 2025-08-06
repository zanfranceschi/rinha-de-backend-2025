# 🧠 Payment Processor Orchestrator (Bun + Redis)

Este projeto é uma API de orquestração de pagamentos desenvolvida com [Bun](https://bun.sh/) e Redis, projetada para distribuir requisições entre dois processadores de pagamento (default e fallback), monitorar suas saúdes e manter um histórico otimizado para gerar relatórios rápidos via Redis.

---

## ⚙️ Tecnologias

- [Bun](https://bun.sh/) `v1.2.19`
- Redis como armazenamento principal de eventos
- Fetch API nativa para chamadas HTTP
- Sem dependências externas (100% Bun + Redis)

---

## 🏗️ Arquitetura

- Processamento de pagamentos com fallback baseado em saúde do processador.
- Fila em memória (`paymentQueue`) para processamento assíncrono.
- Cache e lock via Redis para health checks otimizados.
- Resumo de pagamentos baseado em intervalo de datas.

---

## 🔥 Endpoints

### `POST /payments`

Enfileira uma nova requisição de pagamento para o processador mais saudável.

**Body (JSON):**
```json
{
  "correlationId": "uuid",
  "amount": 123.45
}
```

**Retorno:** `202 Accepted` se enfileirado corretamente.

---

### `GET /payments-summary?from={ISO}&to={ISO}`

Gera um resumo de pagamentos por processador entre dois timestamps.

**Exemplo:**
```
GET /payments-summary?from=2025-07-01T00:00:00Z&to=2025-08-01T00:00:00Z
```

**Retorno (JSON):**
```json
{
  "default": {
    "totalRequests": 42,
    "totalAmount": 2345.67
  },
  "fallback": {
    "totalRequests": 12,
    "totalAmount": 789.01
  }
}
```

---

### `POST /purge-payments`

Limpa o histórico local de pagamentos no Redis e chama os endpoints de purge dos processadores.

**Header obrigatório:**
```
X-Rinha-Token: 123
```

---

## ⚙️ Funcionalidades

- 🧠 Balanceamento inteligente entre processadores via /payments/service-health

- 🔁 Fila assíncrona in-memory para evitar sobrecarga e garantir ordenação

- 🧮 Sumarização de métricas por intervalo de tempo com Redis (LPUSH + LRANGE)

- 🔒 Semáforo Redis via SET NX EX para controle de verificação de saúde

- ⚡ Cache TTL do processador mais rápido por até 7 segundos

---

## 🧪 Health Check Dinâmico

- Executado apenas por uma instância via **lock Redis** (`SET NX EX`).
- Compara `minResponseTime` dos processadores.
- Salva resultado no cache por 5–7 segundos (`cachedProcessor`).
- Evita chamadas redundantes e garante eficiência.

---

## 🐳 Docker

### `Dockerfile` multi-stage otimizado para o Docker Hub

---

## 🧰 Variáveis de ambiente (via `config.ts`)

Configure os endpoints dos processadores de pagamento no arquivo `src/config.ts`:

```ts
export const CONFIG = {
  DEFAULT_PROCESSOR_URL: "http://localhost:8001",
  FALLBACK_PROCESSOR_URL: "http://localhost:8002",
};
```

---

## 🚀 Executando

1. **Instale as dependências:**
   ```bash
   bun install
   ```

2. **Inicie o Redis localmente (exemplo via Docker):**
   ```bash
   docker run -p 6379:6379 redis
   ```

3. **Rode a aplicação:**
   ```bash
   bun src/main.ts
   ```

---

## 📂 Estrutura

```
.
├── src/
│   ├── main.ts           # Entry point do servidor
│   ├── config.ts         # Configuração de endpoints
│   ├── types.ts          # Tipos globais
│   ├── health.ts         # Health check inteligente
│   └── summary.ts        # Log e relatório de pagamentos
```

---

## 📌 Observações

- O projeto usa Redis como store de eventos (sem persistência em disco).
- Ideal para benchmarks, simulações e desafios de performance como a **Rinha de Backend**.
- Baixo consumo de CPU e memória, feito para escalar horizontalmente com Redis centralizado.

---

## Repositório 

- https://github.com/Davi64Lima/rinha-backend-2025-bun

---
## 📄 Licença

MIT