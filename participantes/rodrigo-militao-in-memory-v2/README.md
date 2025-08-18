# Submissão Rinha de Backend 2025 - [Rodrigo Militão]

Implementação desenvolvida em Go, focada em uma arquitetura assíncrona, resiliente e de alta performance.

## Link para o Repositório do Código Fonte

[https://github.com/rodrigo-militao/go-rinha-backend-2025](https://github.com/rodrigo-militao/go-rinha-backend-2025)

## Arquitetura Escolhida

```mermaid
graph TD
    subgraph Cliente
        A[Cliente k6]
    end

    subgraph "Sua Aplicação"
        B(HaProxy Load Balancer)
        C1[App Go 1]
        C2[App Go 2]
        E1["Worker Pool<br/>(Goroutines - App 1)"]
        E2["Worker Pool<br/>(Goroutines - App 2)"]
    end

    subgraph "Redis"
        D["Fila de Trabalho<br/>(List: payments_queue)"]
        H["Estado / Idempotência<br/>(Hash / SetNX)"]
    end

    subgraph "Serviços Externos"
        G[Processadores de Pagamento]
    end

    A -- Requisição HTTP --> B
    B -- least_conn --> C1
    B -- least_conn --> C2

    C1 -- LPUSH (Enfileira) --> D
    C2 -- LPUSH (Enfileira) --> D

    D -- BLPOP (Consome) --> E1
    D -- BLPOP (Consome) --> E2

    E1 -- Processa --> G
    E2 -- Processa --> G

    E1 -- Salva --> H
    E2 -- Salva --> H
``` 

A solução utiliza um sistema de workers assíncronos para processar os pagamentos. Um HaProxy atua como load balancer para duas instâncias da aplicação Go. As requisições são enfileiradas no Redis (usando Listas como fila de trabalho) e consumidas por um pool de goroutines. A idempotência e o estado final são gerenciados pelo PostgreSQL / Redis (adapte conforme sua escolha final). O sistema também implementa um Circuit Breaker com health checks para lidar com a instabilidade dos processadores de pagamento.

## Stack de Tecnologias

- **Linguagem:** Go
- **Banco de Dados:** Redis
- **Fila/Mensageria:** Redis
- **Load Balancer:** HaProxy