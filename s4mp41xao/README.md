# Rinha de Backend 2025

Este projeto é uma implementação para o desafio da Rinha de Backend 2025, que consiste em criar um intermediador de pagamentos que se comunica com dois Payment Processors (um padrão e um de fallback).

## Arquitetura

A aplicação foi desenvolvida utilizando:

- **Spring Boot 3.2.3** com Java 21
- **PostgreSQL** para persistência de dados
- **WebClient** para comunicação reativa com os Payment Processors
- **Circuit Breaker** para resiliência
- **Docker e Docker Compose** para containerização
- **Nginx** como load balancer

### Componentes

- **2 instâncias da aplicação** (app1, app2) para distribuição de carga
- **Nginx** como load balancer na porta 9999
- **PostgreSQL** para persistência
- **2 Payment Processors** (default com taxa 5%, fallback com taxa 10%)

## Funcionalidades

- ✅ Processamento de pagamentos através de dois Payment Processors
- ✅ Fallback automático em caso de falha do processador padrão
- ✅ Endpoint para resumo de pagamentos processados
- ✅ Persistência de todos os pagamentos no banco de dados
- ✅ Balanceamento de carga entre duas instâncias
- ✅ Circuit breaker para resiliência
- ✅ Validação de dados de entrada

## Endpoints

### POST /payments

Processa um novo pagamento.

**Request:**

```json
{
  "correlationId": "abc-123",
  "amount": 100.50
}
```

**Response:**

```json
{
  "correlationId": "abc-123",
  "amount": 100.50,
  "fee": 5.03,
  "netAmount": 95.47
}
```

### GET /payments-summary

Retorna um resumo dos pagamentos processados.

**Response:**

```json
{
  "processedPayments": 10,
  "processedAmount": 1000.00,
  "processedFees": 50.00,
  "processedNetAmount": 950.00,
  "processors": {
    "defaultProcessor": 8,
    "fallbackProcessor": 2
  }
}
```

## Recursos Utilizados

Conforme os limites da Rinha de Backend 2025:

- **CPU Total**: 1.5 vCPUs
  - nginx: 0.1 CPU
  - app1: 0.6 CPU
  - app2: 0.6 CPU
  - db: 0.15 CPU
  - payment-processor-default: 0.025 CPU
  - payment-processor-fallback: 0.025 CPU

- **Memória Total**: 350MB
  - nginx: 20MB
  - app1: 130MB
  - app2: 130MB
  - db: 40MB
  - payment-processor-default: 15MB
  - payment-processor-fallback: 15MB

## Como executar

### Pré-requisitos

- Docker e Docker Compose

### Executando a aplicação

```bash
docker-compose up -d
```

A aplicação estará disponível em `http://localhost:9999`.

### Executando os testes k6

```bash
cd rinha-test
k6 run rinha.js
```

## Estratégia de Implementação

1. **Resiliência**: Circuit breaker para lidar com instabilidades dos processadores
2. **Performance**: Duas instâncias da aplicação com balanceamento de carga
3. **Fallback**: Processador secundário com taxa maior em caso de falha
4. **Otimização**: Configurações de JVM e PostgreSQL ajustadas para os limites de recursos
5. **Monitoramento**: Logs estruturados para debugging

## Testes

Para executar os testes unitários:

```bash
./mvnw test
```

## Conformidade com a Rinha 2025

- ✅ Duas instâncias de servidores web
- ✅ Load balancer (nginx)
- ✅ Porta 9999 exposta
- ✅ Limites de CPU (1.5) e memória (350MB) respeitados
- ✅ Docker Compose configurado
- ✅ Imagens compatíveis com linux/amd64
- ✅ Modo de rede bridge
- ✅ Endpoints POST /payments e GET /payments-summary implementados