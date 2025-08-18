# Rinha de Backend 2025 - Implementação em C# com Akka.NET - v2

Esta é a minha submissão para a **Rinha de Backend 2025**, desenvolvida em **C#** com foco em alta performance e concorrência eficiente.

## 🚀 Tecnologias Utilizadas

### .NET AOT
Nessa versão, utilizei 2 instancias do backend rodando aot para latencias menores, e um worker para o processamento mais pesado.

### 🧠 Akka.NET
- **Actors com Akka Streams** foram usados para modelar pipelines assíncronos de processamento com backpressure e paralelismo configurável.

### 📨 NATS
- Utilização do PUBSUB

### 🔁 nginx
- Usado como **balanceador de carga HTTP reverso**, distribuindo requisições entre instâncias `backend-1` e `backend-2`.

### 🗄️ PostgreSQL (via Dapper / Npgsql)
- Armazenamento dos pagamentos processados.
- Utilizei **Dapper AOT** para consultas rápidas e simples.
- Utilizei Binary Copy para realizar escritas em batch com baixa latência.
- Realizei tuning de `Connection Pool`, reduzindo latência e evitando timeouts.

## ⚙️ Arquitetura
- Apis mandam mensagem via NATS PUBSUB para o worker.
- O `RouterActor` decide entre os destinos com base na saúde dos serviços, monitoradas pelo **HealthMonitorActor**.
- O `PaymentPipelineActor` usa **Akka Streams** para processar requisições com alto throughput e persistência eficiente.