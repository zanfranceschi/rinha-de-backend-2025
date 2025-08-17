# 🏆 Rinha de Backend 2025

Este projeto é uma implementação para o desafio **Rinha de Backend 2025**

## 🚀 Tecnologias Utilizadas

- **Linguagem:** Java 21
- **Framework:** Spring Boot 3
- **Banco de Dados:** PostgreSQL
- **Servidor Web:** Jetty
- **Build:** Maven
- **Virtualização:** Docker
- **Load Balancer:** HAProxy
- **Compilação Nativa:** GraalVM

## 🏗️ Arquitetura

A arquitetura da aplicação foi projetada para ser resiliente, escalável e de alta performance, com foco em baixa latência na resposta ao cliente. Para isso, a aplicação utiliza um fluxo de processamento totalmente assíncrono.

- **HAProxy:** Atua como um load balancer, distribuindo as requisições entre as instâncias da aplicação backend.
- **Backend (Spring Boot):** A aplicação principal, responsável por receber as requisições de pagamento e orquestrar o processamento assíncrono. O `docker-compose.yml` está configurado para executar duas instâncias da aplicação para alta disponibilidade.
- **PostgreSQL:** O banco de dados utilizado para persistir os dados da aplicação, com otimizações para alta performance.
- **GraalVM:** O projeto está configurado para compilar uma imagem nativa, o que resulta em um tempo de inicialização mais rápido e menor consumo de memória.
- **Jetty:** Servidor web de alta performance configurado para comunicação via Unix Domain Sockets (UDS). Isso otimiza a comunicação com o HAProxy quando ambos rodam no mesmo host, eliminando o overhead da camada TCP/IP.

### ✨ Padrões e Funcionalidades

- **Arquitetura em Camadas:** O código é organizado em camadas (`api`, `core`, `domain`, `infrastructure`), promovendo a separação de responsabilidades e a manutenibilidade.
- **Processamento Assíncrono:** A aplicação utiliza um pipeline de filas em memória e workers para processar os pagamentos de forma assíncrona, garantindo que a API de entrada seja extremamente rápida.
- **Persistência Otimizada:** A aplicação utiliza estratégias de persistência otimizadas com base no volume de dados, alternando entre inserções individuais, em lote (`batch`) e o comando `COPY` do PostgreSQL para máxima eficiência.
- **Cliente HTTP Declarativo:** A comunicação com os processadores de pagamento é feita através de um cliente HTTP declarativo (`@HttpExchange`), simplificando o código e melhorando a legibilidade.
- **Health Check:** Um sistema de health check monitora a saúde dos processadores de pagamento, permitindo que a aplicação troque para um processador de fallback caso o principal fique indisponível.
- **Build Multi-Stage:** O `Dockerfile` utiliza um build multi-stage para criar uma imagem nativa com GraalVM e, em seguida, copia o executável para uma imagem `distroless`, resultando em uma imagem final extremamente enxuta e segura.

## 🌊 Fluxo da Aplicação

O fluxo de processamento de um pagamento é totalmente assíncrono, garantindo uma resposta rápida ao cliente:

```mermaid
graph TD
    A[Cliente] --> B[HAProxy];
    B --> C;
    H --> I[PostgreSQL];
    SEM --> F{Payment Processor};

    subgraph Application
        C{API Spring Boot} --> D[InputPaymentQueue];
        D --> E[PaymentProcessorWorker];
        E --> SEM((Semaphore));
        E --> G[ProcessedPaymentQueue];
        G --> H[PaymentProcessedWorker];
    end
```

1.  O cliente envia uma requisição de pagamento para o HAProxy.
2.  O HAProxy encaminha a requisição para uma das instâncias do backend.
3.  A API recebe a requisição, a enfileira na `InputPaymentQueue` e retorna imediatamente `202 ACCEPTED`.
4.  O `PaymentProcessorWorker` consome da `InputPaymentQueue`, envia o pagamento para o processador externo e enfileira o resultado na `ProcessedPaymentQueue`.
5.  O `PaymentProcessedWorker` consome da `ProcessedPaymentQueue` e persiste o pagamento processado no PostgreSQL.