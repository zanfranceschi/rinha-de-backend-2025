# Rinha de Backend 2025 - jairoandre/rb2025

## Descrição

Solução desenvolvida em Golang para o desafio Rinha de Backend 2025. Link do repositório [aqui](https://github.com/jairoandre/rb2025)

## Arquitetura

A aplicação utiliza a biblioteca padrão Golang **net/http** para criar uma instância de um servidor HTTP Web multiplexado (__NewServerMUX__).
Ao receber uma requisiçào de pagamento, o *handler* encaminha o evento para uma fila *redis*, os eventos são posteriormente processados de forma paralelizada com o uso de *channels* e *go coroutines*.

O consumidor de eventos encaminha as requisições para um processador externo *default*. Em caso de falha as requisições são encaminhadas para o processador *fallback*.

Se os dois processadores apresentarem falhas, o evento de pagamento é redirecionado para fila e o consumo de eventos é suspendido temporariamente para verificação das saúdes dos mesmos. Assim que qualquer um dos processadores se apresentar disponível, o consumo é retomado.

Os eventos de pagamento só são gravados na base de dados após a confirmação dos processadores externos.

## Componentes da Solução

- nginx (load balancer)
- backend em golang
- postgres para persistência dos dados
- redis para mensageria

> docker-compose.yml

```yaml
version: '3.8'

x-services-templates:
  backend-app: &backend-app
    image: docker.io/jairoandre/rb2025:latest
    environment:
      - PAYMENT_PROCESSOR_URL_DEFAULT=http://payment-processor-default:8080
      - PAYMENT_PROCESSOR_URL_FALLBACK=http://payment-processor-fallback:8080
      - DB_HOST=postgres
      - BROKER_URL=redis:6379
      - CONSUMER_NAME=${container_name}
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    networks:
      - backend
      - payment-processor
    deploy:
      resources:
        limits:
          cpus: "0.4"
          memory: "90MB"

services:
  # Load Balancer / API Gateway
  nginx:
    image: nginx:alpine
    container_name: nginx
    ports:
      - "9999:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    depends_on:
      - backend1
      - backend2
    networks:
      - backend
      - payment-processor
    deploy:
      resources:
        limits:
          cpus: "0.2"
          memory: "20MB"

  # Backend Instance 1
  backend1:
    <<: *backend-app
    container_name: backend1

  # Backend Instance 2
  backend2:
    <<: *backend-app
    container_name: backend2

  postgres:
    image: docker.io/library/postgres:17-alpine
    container_name: postgres
    hostname: postgres
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      timeout: 5s
      retries: 5
    environment:
      POSTGRES_USER: "postgres"
      POSTGRES_PASSWORD: "postgres"
      POSTGRES_DB: "rb2025"
    volumes:
      - ./init.sql:/docker-entrypoint-initdb.d/ddl.sql
    ports:
      - "5432:5432"
    networks:
      - backend
    deploy:
      resources:
        limits:
          cpus: "0.3"
          memory: "90MB"
  redis:
    image: redis:7.2-alpine
    container_name: redis
    hostname: redis
    command: redis-server --save "" --appendonly no --maxclients 1000
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 5s
      timeout: 5s
      retries: 5
    ports:
      - "6379:6379"
    networks:
      - backend
    deploy:
      resources:
        limits:
          cpus: "0.2"
          memory: "60MB"

networks:
  backend:
    driver: bridge
  payment-processor:
    external: true
```