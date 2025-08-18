# Rinha de Backend 2025 - Christian

## 🚀 Tecnologias Utilizadas

- **Linguagem**: Rust 1.82
- **Framework Web**: Axum
- **Runtime Assíncrono**: Tokio
- **Load Balancer**: HAProxy
- **Storage**: In-Memory com DashMap
- **HTTP Client**: Reqwest com connection pooling

## 🏗️ Arquitetura

- **2 instâncias** da aplicação Rust
- **HAProxy** como load balancer na porta 9999
- **Circuit breakers** para fallback inteligente
- **Processamento assíncrono** de pagamentos
- **Métricas atômicas** para alta performance

## 🔧 Funcionalidades

### Otimizações de Performance
- Pool de conexões HTTP reutilizáveis
- Processamento em batch assíncrono
- Circuit breakers para alta disponibilidade
- Load balancing inteligente entre processors
- Métricas atômicas (lockless)

### Resilência
- Fallback automático entre processors
- Health checks dos payment processors
- Retry com backoff exponencial
- Timeout configurável

### Monitoramento
- Endpoint `/metrics` com estatísticas detalhadas
- Circuit breaker status
- Success rate tracking
- Latência média por processor

## 🚦 Como Executar

```bash
# 1. Subir os payment processors primeiro
cd payment-processor/
docker compose up -d

# 2. Subir a aplicação
cd ../
docker compose up -d

# 3. Testar
curl http://localhost:9999/health
```

## 📊 Endpoints

- `POST /payments` - Processar pagamento
- `GET /payments-summary` - Resumo de pagamentos
- `GET /metrics` - Métricas da aplicação
- `GET /health` - Health check

## 🎯 Estratégia de Otimização

1. **Processor Selection**: Sempre tenta o default primeiro (menor taxa)
2. **Circuit Breakers**: Evita processors com falhas frequentes
3. **Async Processing**: Queue assíncrona para não bloquear requests
4. **Connection Pooling**: Reutiliza conexões HTTP
5. **Load Balancing**: HAProxy distribui carga entre 2 instâncias

## 📈 Limites de Recursos

- **CPU**: 1.5 unidades total
- **Memória**: 350MB total
- **Instâncias**: 2 apps + HAProxy

Distribuição:
- HAProxy: 0.5 CPU, 50MB
- App1: 0.5 CPU, 150MB  
- App2: 0.5 CPU, 150MB

**Repositório**: https://github.com/christian/rinha-backend-2025