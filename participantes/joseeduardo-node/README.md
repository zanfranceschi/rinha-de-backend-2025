## 📖 Sobre o Projeto

Este é um projeto desenvolvido para a **Rinha de Backend 2025**, focado em alta performance e escalabilidade para processamento de pagamentos em massa. O sistema foi projetado para lidar com picos de até **500 requisições por segundo** mantendo consistência e confiabilidade.

### 🎯 Objetivo

Criar uma API robusta capaz de processar pagamentos de forma assíncrona, garantindo:

- **Idempotência**: Evita pagamentos duplicados
- **Resiliência**: Fallback automático entre processadores
- **Escalabilidade**: Múltiplas instâncias com load balancing
- **Performance**: Processamento em fila com alta concorrência

## 🛠️ Tecnologias Utilizadas

### **Backend Framework**

- **[NestJS](https://nestjs.com/)** - Framework Node.js robusto e escalável
- **[TypeScript](https://www.typescriptlang.org/)** - Tipagem estática para maior confiabilidade

### **Banco de Dados**

- **[PostgreSQL 17](https://www.postgresql.org/)** - Banco relacional otimizado para alta performance
- **[TypeORM](https://typeorm.io/)** - ORM para TypeScript/JavaScript

### **Queue e Cache**

- **[Redis 7.2](https://redis.io/)** - Armazenamento em memória para cache e filas
- **[BullMQ](https://docs.bullmq.io/)** - Sistema de filas robusto para processamento assíncrono

### **Load Balancing**

- **[Nginx](https://nginx.org/)** - Reverse proxy e load balancer
- **Algoritmo least_conn** - Distribuição inteligente de requisições

### **Infraestrutura**

- **[Docker](https://www.docker.com/)** - Containerização da aplicação
- **[Docker Compose](https://docs.docker.com/compose/)** - Orquestração de múltiplos serviços

### **Otimizações Aplicadas**

- ⚡ **UNLOGGED Tables** - Performance máxima em inserts
- 🔄 **Connection Pooling** - Reutilização eficiente de conexões
- 📊 **Query Optimization** - Índices únicos e queries SQL diretas
- 🛡️ **Rate Limiting** - Proteção contra sobrecarga
- 🔁 **Circuit Breaker** - Tolerância a falhas
- 📝 **Retry com Backoff** - Reprocessamento inteligente

### 🔄 Fluxo de Processamento

1. **Recepção**: Nginx distribui requisições entre as 3 instâncias da API
2. **Enfileiramento**: Pagamentos são adicionados na fila Redis (BullMQ)
3. **Processamento**: Workers consomem a fila e tentam processar via:
   - Processador principal (default)
   - Processador de fallback (se o principal falhar)
4. **Persistência**: Pagamentos bem-sucedidos são salvos no PostgreSQL
5. **Idempotência**: Sistema evita duplicação via `correlation_id` único

## 📋 Arquitetura e Recursos dos Serviços

| Serviço      | Imagem                               | CPU        | Memória | Porta | Descrição                     |
| ------------ | ------------------------------------ | ---------- | ------- | ----- | ----------------------------- |
| **api1**     | `jos3duardo/rinha-backend-2025:v1.0` | 0.3 cores  | 67MB    | -     | API NestJS - Instância 1      |
| **api2**     | `jos3duardo/rinha-backend-2025:v1.0` | 0.3 cores  | 67MB    | -     | API NestJS - Instância 2      |
| **api3**     | `jos3duardo/rinha-backend-2025:v1.0` | 0.3 cores  | 67MB    | -     | API NestJS - Instância 3      |
| **nginx**    | `nginx:latest`                       | 0.10 cores | 9MB     | 9999  | Load Balancer / Reverse Proxy |
| **redis**    | `redis:7.2-alpine`                   | 0.3 cores  | 15MB    | 6379  | Queue e Cache (BullMQ)        |
| **database** | `postgres:17-alpine`                 | 0.20 cores | 125MB   | 5432  | Banco de Dados Principal      |

### 📊 Resumo de Recursos

| Métrica               | Valor Total                |
| --------------------- | -------------------------- |
| **CPU Total**         | 1.5 cores                  |
| **Memória Total**     | 350MB                      |
| **Instâncias da API** | 3                          |
| **Redes**             | backend, payment-processor |

### 🔧 Configurações Especiais

- **PostgreSQL**: Otimizado para performance com `fsync=0`, `synchronous_commit=0`
- **Redis**: Plataforma linux/amd64 para compatibilidade
- **Nginx**: Load balancer com algoritmo `least_conn`
- **APIs**: Configuradas com restart automático e dependências

### 🌐 Endpoints Expostos

- **API Principal**: `http://localhost:9999` (via Nginx)
- **Redis**: `localhost:6379` (para desenvolvimento)
- **PostgreSQL**: `localhost:5432` (para desenvolvimento)
