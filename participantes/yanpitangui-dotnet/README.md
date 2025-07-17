# Rinha de Backend 2025 - Implementação em C# com Akka.NET

Esta é a minha submissão para a **Rinha de Backend 2025**, desenvolvida em **C#** com foco em alta performance e concorrência eficiente.

## 🚀 Tecnologias Utilizadas

### 🧠 Akka.NET
- **Sistema de atores distribuído** que permite modelar concorrência de forma eficiente.
- Utilizei **Akka Cluster** para habilitar múltiplas instâncias com descoberta e comunicação distribuída.
- **Cluster Singleton** gerencia monitoramento de saúde centralizado, evitando chamadas desnecessárias a endpoints limitados.
- **Actors com Akka Streams** foram usados para modelar pipelines assíncronos de processamento com backpressure e paralelismo configurável.

### 🔁 nginx
- Usado como **balanceador de carga HTTP reverso**, distribuindo requisições entre instâncias `backend-1` e `backend-2`.

### 🗄️ PostgreSQL (via Dapper / Npgsql)
- Armazenamento dos pagamentos processados.
- Utilizei **Dapper** para consultas rápidas e simples.
- Utilizei Binary Copy para realizar escritas em batch com baixa latência.
- Realizei tuning de `Connection Pool`, reduzindo latência e evitando timeouts.
- O acesso ao banco é feito em paralelo, diretamente no fluxo do ator.

## ⚙️ Arquitetura

- Cada backend roda seu próprio pool de **RouterActor**, responsável por rotear a requisição para um `PaymentProcessorActor`.
- O `RouterActor` decide entre os destinos com base na saúde dos serviços, monitoradas pelo **HealthMonitorActor**.
- O `PaymentProcessorActor` usa **Akka Streams** para processar requisições com alto throughput e persistência eficiente.