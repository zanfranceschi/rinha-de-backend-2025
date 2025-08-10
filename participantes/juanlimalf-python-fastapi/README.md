# Payment Processor API - Rinha de Backend

API para processamento de pagamentos desenvolvida para a Rinha de Backend, utilizando FastAPI, Redis e Nginx como load balancer.

## 📋 Visão Geral

Este projeto implementa uma API de processamento de pagamentos com arquitetura distribuída, utilizando:

- **FastAPI**: Framework web moderno e rápido para Python
- **Redis**: Cache e message broker para Celery
- **Nginx**: Load balancer e proxy reverso
- **Docker**: Containerização de todos os serviços

## 🏗️ Arquitetura

O sistema é composto por múltiplos containers que trabalham em conjunto:

- **2 instâncias da API** (api, api2): Para alta disponibilidade
- **1 Worker**: Para processamento assíncrono de pagamentos
- **Nginx**: Load balancer entre as instâncias da API
- **Redis**: Message broker e bando de dados

## 🚀 Funcionalidades

### Endpoints Principais

- `POST /payments`: Recebe solicitações de pagamento para processamento assíncrono
- `GET /payments-summary`: Retorna resumo de pagamentos com filtros opcionais de data
- `POST /payments-purge`: Limpa todos os dados de pagamentos do banco

## 📊 Especificações dos Containers

| Container | CPU (cores) | Memória (MB) | Imagem | Função |
|-----------|-------------|--------------|---------|---------|
| **api** | 0.4 | 85 | Custom Build | API Principal |
| **api2** | 0.4 | 85 | Custom Build | API Secundária |
| **worker** | 0.3 | 90 | Custom Build | Worker Celery |
| **nginx** | 0.2 | 30 | nginx:latest | Load Balancer |
| **redis** | 0.2 | 60 | redis:8.0.3 | Cache/Message Broker |

### **Total de Recursos**
- **CPU Total**: 1.50 cores
- **Memória Total**: 350 MB


## 🚀 Como Executar

### Pré-requisitos
- Docker
- Docker Compose

### Executando o Projeto

1. **Clone o repositório**
```bash
git clone "https://github.com/Juanlimalf/payment_processor-rinha_backend_2025"
cd payment-processor-rinha-backend
```

2. **Inicie os processadores de pagamento**
```bash
cd payment-processor
docker-compose up -d
cd ..
```

3. **Inicie a aplicação principal**
```bash
docker-compose up -d
```

4. **Verifique se todos os serviços estão rodando**
```bash
docker-compose ps
```

### Acessando a Aplicação

- **API Principal**: http://localhost:9999

## 📝 Configurações


## 👨‍💻 Autor

**Juan Lima** - [juanlimalf@gmail.com](mailto:juanlimalf@gmail.com)

**linkdIn** - [https://www.linkedin.com/in/juanlimalf/](https://www.linkedin.com/in/juanlimalf/)