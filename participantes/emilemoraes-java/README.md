# 🏦 Payment Gateway API

This project implements a resilient and scalable payment gateway capable of handling financial transactions through multiple external processors. It uses asynchronous processing, health-check logic, and persistent storage.

---

## 🚀 Features

### ➕ POST `/payments`

Enqueues a new payment attempt in Redis for asynchronous processing.

**Sample Body:**

```json
{
  "correlationId": "b12eb1e6-95a1-4df4-9822-3dc3af8f5928",
  "amount": 1024.50
}
```

---

### 📊 GET `/payments-summary`

Returns a summary of processed payments, grouped by `default` and `fallback` processors.

**Query Parameters (optional):**

* `from`: ISO 8601 UTC timestamp
* `to`: ISO 8601 UTC timestamp

**Sample Response:**

```json
{
  "default": {
    "totalRequests": 10,
    "totalAmount": 3023.30
  },
  "fallback": {
    "totalRequests": 3,
    "totalAmount": 523.50
  }
}
```

---

## ⚙️ Tech Stack

* Java 17 + Spring Boot
* PostgreSQL
* Redis (asynchronous broker)
* Docker / Docker Compose
* NGINX (for load balancing)

---

## 📂 Main Structure

* `PaymentQueue` – Enqueues payments into Redis.
* `PaymentProcessingService` – Background worker that dequeues and routes to payment processors.
* `ServiceHealthManager` – Maintains health status of external services.
* `PaymentRepository` – Persists successful transactions to PostgreSQL.
* `PaymentSummaryController` – Exposes `/payments-summary` endpoint.

---

## 🐳 Docker Compose

Run the stack:

```bash
docker-compose up --build
```

Available services:

* API Gateway: [http://localhost:9999](http://localhost:9999)
* Redis: localhost:6379
* PostgreSQL: localhost:5432 (`rb2025`, user: `postgres`, password: `postgres`)

---

## 📌 Configuration

Environment variables are managed via `application.yml` and Docker Compose:

* Payment processors:

    * `PAYMENT_PROCESSOR_URL_DEFAULT`
    * `PAYMENT_PROCESSOR_URL_FALLBACK`
* Database: `DB_HOST`
* Redis broker: `BROKER_URL`
* Redis queue: `payment.queue.name`

---

## 🧰 Reliability & Health Check

* Scheduled task periodically dequeues payments and sends to available processors.
* Health-check endpoints (`/service-health`) determine service availability.
* Failed payments are re-queued automatically.

---

## 🤝 Contributing

Pull requests are welcome. For major changes, open an issue to discuss your proposal first.

---

## 📊 Load & Fault Tolerance

This system was built for high-load scenarios:

* Handles thousands of requests via Redis queue.
* Simulates processor failures.
* Remains consistent across retries and fallback logic.

---
