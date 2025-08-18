# Rinha de Backend 2025 - Python

Sistema criado em Python para participação da rinha de backend com intuito de aprender e me aventurar 
nesta área.

Se quiserem ver a implementação aqui está o [repo](https://github.com/lucas-porto/rinha-python-2025).

## Tecnologias Utilizadas

### **Backend**
- **Python 3.11** com Starlette e Uvicorn
- **Workers separados** com 6 workers assíncronos (2 containers × 3 workers)
- **Redis** para fila de mensagens e cache
- **Retry logic** com fallback automático
- **Connection pooling** para HTTP clients

### **Infraestrutura**
- **Redis 7** otimizado para filas
- **HAProxy 2.8** com load balancing round-robin
- **Docker & Docker Compose**
- **Containers separados** para app e workers

## Otimizações Implementadas

### **1. HAProxy Load Balancer**
- Balanceamento `roundrobin` para distribuição equilibrada
- Health checks configurados (status 204)
- Timeouts otimizados (5s connect, 50s client/server)
- Reutilização de conexões

### **2. Workers Separados**
- 2 containers dedicados para processamento
- 6 workers assíncronos total (3 por container)
- Semáforo limitando 10 requests concorrentes por worker
- Isolamento completo de recursos

### **3. Redis Queue System**
- Fila `payment_queue` para processamento assíncrono
- LPOP/RPUSH para FIFO garantido
- Retry automático com contador
- Cache para otimização de performance

### **4. Async Processing**
- Processamento assíncrono com asyncio
- Semáforos para controle de concorrência
- Non-blocking I/O operations
- Graceful shutdown com signal handling

### **5. Fallback Strategy**
- **Default**: Processador principal
- **Fallback**: Processador secundário
- **Error**: Salvamento com status de erro
- **Retry**: Até 3 tentativas por payment

## Arquitetura

**Fluxo de Requisições:**
1. **k6** envia requisições para **HAProxy** (porta 9999)
2. **HAProxy** faz load balancing para **App** (Starlette)
3. **App** envia pagamentos para **Redis Queue**
4. **Workers** processam a fila e enviam para processadores
5. **Resultados** são salvos no banco de dados

## Configurações de Performance

### **Docker Compose**
- 1 instância da App (Starlette)
- 2 containers de Worker (6 workers total)
- Redis otimizado para filas
- HAProxy com load balancing

### **Otimizações Redis**
```redis
maxmemory 60mb
maxmemory-policy allkeys-lru
save ""
appendonly no
```

### **Recursos Limitados**
- **App**: 0.4 CPU, 120MB RAM
- **Worker**: 0.3 CPU, 60MB RAM (cada)
- **HAProxy**: 0.2 CPU, 50MB RAM
- **Redis**: 0.3 CPU, 60MB RAM
- **Total**: 1.5 CPU, 350MB RAM

## Estratégia de Fallback

- **Default**: Processador principal
- **Fallback**: Processador secundário (se default falhar)
- **Error**: Salvamento com status "error"
- **Retry**: Máximo 3 tentativas por payment
- **Health Check**: Monitoramento contínuo

## Endpoints

- `POST /payments` - Criar pagamento
- `GET /payments-summary?from=X&to=Y` - Resumo de pagamentos
- `GET /health` - Health check (status 204)
- `POST /purge-payments` - Limpar pagamentos (teste)
