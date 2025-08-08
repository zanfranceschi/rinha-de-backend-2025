# 🏆 Rinha de Backend - High-Performance Payment Processing System

## 👨‍💻 Autor

**Jose Hamilton Santos Junior**
- GitHub: [@jhamiltonjunior](https://github.com/jhamiltonjunior)
- LinkedIn: [@jhamiltonjunior](https://linkedin.com/in/jhamiltonjunior)
- Twiter: [@hamiltonj_dev](https://x.com/hamiltonj_dev)

[![Go Version](https://img.shields.io/badge/go-%3E%3D1.24-00ADD8)](https://golang.org/)
[![Docker](https://img.shields.io/badge/docker-%E2%9C%93-2496ED)](https://www.docker.com/)
[![MongoDB](https://img.shields.io/badge/mongodb-%E2%9C%93-47A248)](https://www.mongodb.com/)
[![Redis](https://img.shields.io/badge/redis-%E2%9C%93-DC382D)](https://redis.io/)
[![Nginx](https://img.shields.io/badge/nginx-%E2%9C%93-269539)](https://nginx.org/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

> **Uma solução robusta e escalável para processamento de pagamentos em alta performance, desenvolvida em Go com arquitetura distribuída e balanceamento de carga.**

## 📋 Índice

- [Visão Geral](#-visão-geral)
- [Arquitetura](#-arquitetura)
- [Funcionalidades](#-funcionalidades)
- [Tecnologias](#-tecnologias)
- [Pré-requisitos](#-pré-requisitos)
- [Instalação](#-instalação)
- [Uso](#-uso)
- [API Endpoints](#-api-endpoints)
- [Testes de Performance](#-testes-de-performance)
- [Monitoramento](#-monitoramento)
- [Configuração](#-configuração)
- [Contribuição](#-contribuição)
- [Licença](#-licença)

## 🎯 Visão Geral

O **Rinha de Backend** é um sistema de processamento de pagamentos desenvolvido especificamente para competições de performance, capaz de processar centenas de transações por segundo com alta disponibilidade e consistência de dados.

### Principais Características

- 🚀 **Alta Performance**: Processamento assíncrono com workers concorrentes
- 🔄 **Tolerância a Falhas**: Sistema de fallback automático entre processadores
- 📊 **Escalabilidade Horizontal**: Load balancer com 3 instâncias da aplicação
- 🛡️ **Resiliência**: Mecanismo de retry e circuit breaker
- 📈 **Observabilidade**: Métricas detalhadas e dashboards em tempo real

## 🏗️ Arquitetura

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Load Balancer │    │   API Instances  │    │   Databases     │
│     (Nginx)     │    │                  │    │                 │
├─────────────────┤    ├──────────────────┤    ├─────────────────┤
│                 │    │  ┌─────────────┐ │    │                │
│  Port: 9999     ├────┤  │ rinha-api-1 │ ├────┤                │
│                 │    │  │ rinha-api-2 │ │    │   MongoDB      │
│  Round Robin    │    │  │ rinha-api-3 │ │    │                │
│  Distribution   │    │  └─────────────┘ │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                                │
                                │
┌─────────────────────────────────────────────────────────────────┐
│                    Worker Pool System                           │
├─────────────────────────────────────────────────────────────────┤
│  ┌──────────────┐  ┌──────────────┐  ┌─────────────────────────┐│
│  │   Primary    │  │   Fallback   │  │      Retry Queue        ││
│  │  Processor   │  │  Processor   │  │     (3000 buffer)       ││
│  │  (Channel)   │  │  (Channel)   │  │                         ││
│  └──────────────┘  └──────────────┘  └─────────────────────────┘│
└─────────────────────────────────────────────────────────────────┘
```

### Componentes da Arquitetura

- **Load Balancer**: Nginx com distribuição round-robin
- **API Layer**: 3 instâncias FastHTTP para máxima performance
- **Worker Pool**: 20 workers concorrentes para processamento assíncrono
- **Data Layer**: MongoDB para persistência
- **External Services**: Integração com processadores de pagamento externos

## ✨ Funcionalidades

### Core Features
- ✅ **Processamento de Pagamentos**: API REST para criação de transações
- ✅ **Fallback Automático**: Mudança transparente entre processadores
- ✅ **Relatórios em Tempo Real**: Endpoint de summary com filtros temporais
- ✅ **Sistema de Retry**: Reprocessamento automático de falhas
- ✅ **Purge de Dados**: Limpeza de dados para testes

### Performance Features
- ⚡ **Channel-based Queuing**: Sistema de filas não-bloqueantes
- 🔄 **Connection Pooling**: Reutilização eficiente de conexões
- 📊 **Metrics Collection**: Coleta de métricas para observabilidade
- 🛡️ **Circuit Breaker**: Proteção contra cascata de falhas

## 🛠️ Tecnologias

### Backend
- **Go 1.24**: Linguagem principal para máxima performance
- **FastHTTP**: Framework web de alta performance
- **FastHTTP Router**: Roteamento otimizado

### Databases
- **MongoDB**: Banco de dados principal (NoSQL)
- **Redis**: Cache e sessões (comentado para otimização)

### Infrastructure
- **Docker & Docker Compose**: Containerização e orquestração
- **Nginx**: Load balancer e reverse proxy

### Testing & Monitoring
- **K6**: Testes de carga e performance
- **InfluxDB**: Armazenamento de métricas temporais
- **Grafana**: Dashboards e visualização

## 📋 Pré-requisitos

- Docker 20.10+
- Docker Compose 2.0+
- Go 1.24+ (para desenvolvimento)
- Make (opcional, para comandos facilitados)

## 🚀 Instalação

### 1. Clone o Repositório

```bash
git clone https://github.com/jhamiltonjunior/rinha-de-backend.git
cd rinha-de-backend
```

### 2. Configuração do Ambiente

```bash
# Copie o arquivo de ambiente (se existir)
# Mas apenas se for usar o projeto, caso contrario pode ignorar
cp .env.example .env

# Configure as variáveis necessárias no .env
```

### 3. Build e Deploy

```bash
# Usando Make (recomendado)
make up

# Ou usando Docker Compose diretamente
docker compose up -d --build
```

### 4. Verificação

```bash
# Verifique se todos os serviços estão rodando
docker compose ps

# Teste a API
curl -X POST http://localhost:9999/payments \
  -H "Content-Type: application/json" \
  -d '{"correlationId": "123e4567-e89b-12d3-a456-426614174000", "amount": 19.90}'
```

## 📖 Uso

### Inicialização do Sistema

```bash
# Subir todos os serviços
make up

# Visualizar logs em tempo real
make logs-app-1

# Parar todos os serviços
make down
```

### Testando a API

```bash
# Criar um pagamento
curl -X POST http://localhost:9999/payments \
  -H "Content-Type: application/json" \
  -d '{
    "correlationId": "550e8400-e29b-41d4-a716-446655440000",
    "amount": 99.99
  }'

# Consultar resumo de pagamentos
curl "http://localhost:9999/payments-summary?from=2025-01-01T00:00:00Z&to=2025-12-31T23:59:59Z"
```

## 🔌 API Endpoints

### `POST /payments`
**Criar um novo pagamento**

```json
// Request Body
{
  "correlationId": "uuid-v4-string",
  "amount": 19.90
}

// Response: 202 Accepted (processamento assíncrono)
// Response: 429 Too Many Requests (buffer cheio)
```

### `GET /payments-summary`
**Obter resumo de pagamentos**

```bash
GET /payments-summary?from=2025-01-01T00:00:00Z&to=2025-01-31T23:59:59Z
```

```json
// Response: 200 OK
{
  "default": {
    "totalRequests": 1250,
    "totalAmount": 24875.00
  },
  "fallback": {
    "totalRequests": 45,
    "totalAmount": 895.50
  }
}
```

### `POST /purge-payments`
**Limpar dados de pagamentos (para testes)**

```json
// Response: 202 Accepted
```

## 🧪 Testes de Performance

### Configuração do K6

O projeto inclui scripts K6 para testes de carga abrangentes:

```bash
# Navegar para o diretório de testes
cd k6-dashboard

# Subir infraestrutura de monitoramento
docker-compose up -d influxdb grafana

# Executar teste de carga
docker-compose run --rm k6 run /scripts/rinha.js
```

### Scripts de Teste Disponíveis

1. **`rinha.js`**: Teste completo da competição
2. **`script.js`**: Teste básico de funcionalidade  
3. **`test-payment.js`**: Teste focado em pagamentos
4. **`requests.js`**: Utilitários de requisição

### Métricas Principais

- **Throughput**: Requisições por segundo
- **Latência**: P99, P95, P50
- **Taxa de Erro**: Porcentagem de falhas
- **Consistência**: Verificação de dados entre processadores

## 📊 Monitoramento

### Dashboards Grafana

Acesse `http://localhost:3000` para visualizar:

- **Performance Dashboard**: Métricas de latência e throughput
- **Error Dashboard**: Análise de falhas e recuperação
- **Business Dashboard**: Métricas de negócio e financeiras

### Métricas Customizadas

```javascript
// Exemplo de métricas coletadas
{
  "total_liquido": 18750.25,
  "total_bruto": 19650.00,
  "total_taxas": 899.75,
  "p99": "45ms",
  "inconsistencias": 0,
  "pagamentos_realizados": {
    "default": 1200,
    "fallback": 50
  }
}
```

## ⚙️ Configuração

### Variáveis de Ambiente

```bash
# Aplicação
APP_PORT=3000
RUN_VERIFY_PAYMENT_SERVICE=true

# Databases
POSTGRES_URL=postgres://user:password@postgres:5432/database
REDIS_ADDR=redis:6379

# External Services
PAYMENT_PROCESSOR_URL_DEFAULT=http://payment-processor-default:8080
PAYMENT_PROCESSOR_URL_FALLBACK=http://payment-processor-fallback:8080

# Message Queue
NATS_URL=nats://nats:4222
```

### Limites de Recursos

```yaml
# docker-compose.yml
deploy:
  resources:
    limits:
      cpus: "0.25"    # Por instância da API
      memory: "30MB"   # Otimizado para competição
```

### Configuração do Nginx

```nginx
upstream rinha_app_servers {
    server rinha-api-1:3000;
    server rinha-api-2:3000; 
    server rinha-api-3:3000;
}
```

## 🏆 Performance Benchmarks

### Resultados da Competição

- **Throughput**: 500+ req/s sustentados
- **Latência P99**: < --ms
- **Disponibilidade**: ---%+
- **Consistência**: 0 inconsistências detectadas nos meus teste locais

### Otimizações Implementadas

1. **Memory Management**: Pools de buffers reutilizáveis
2. **Connection Reuse**: HTTP keep-alive habilitado
3. **Async Processing**: Workers não-bloqueantes
4. **Resource Limits**: Configuração otimizada por container

## 🤝 Contribuição

Contribuições são bem-vindas! Para contribuir:

1. Fork o projeto
2. Crie sua feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

### Guidelines

- Siga os padrões de código Go
- Adicione testes para novas funcionalidades
- Documente mudanças significativas
- Mantenha compatibilidade com a API existente

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para detalhes.

## 🙏 Agradecimentos

- [Rinha de Backend](https://github.com/zanfranceschi/rinha-de-backend-2025) - Competição original
- Comunidade Go Brasil
- Contributors e testers

---

<div align="center">

**⭐ Se este projeto foi útil, não esqueça de dar uma estrela!**

[🐛 Reportar Bug](https://github.com/jhamiltonjunior/rinha-de-backend/issues) | 
[✨ Solicitar Feature](https://github.com/jhamiltonjunior/rinha-de-backend/issues) | 
[💬 Discussões](https://github.com/jhamiltonjunior/rinha-de-backend/discussions)

</div>
