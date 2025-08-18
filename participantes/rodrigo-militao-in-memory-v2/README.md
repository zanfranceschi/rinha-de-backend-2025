# Submissão Rinha de Backend 2025 - [Rodrigo Militão]

Implementação desenvolvida em Go, focada em **baixa latência**, **processamento assíncrono** e **uso eficiente de memória**.  
Nesta versão, a solução abandona o Redis e utiliza um **banco em memória customizado (in-memory DB)** para armazenar e agregar os pagamentos.

## Link para o Repositório do Código Fonte

[https://github.com/rodrigo-militao/go-rinha-backend-2025/tree/in-memory-db](https://github.com/rodrigo-militao/go-rinha-backend-2025/tree/in-memory-db)

Branch: in-memory-db

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
        F["In-Memory DB<br/>(Thread-Safe)"]
    end

    subgraph "Serviços Externos"
        G[Processadores de Pagamento]
    end

    A -- Requisição HTTP --> B
    B -- least_conn --> C1
    B -- least_conn --> C2

    C1 -- Enfileira --> E1
    C2 -- Enfileira --> E2

    E1 -- Processa --> G
    E2 -- Processa --> G

    E1 -- Salva/Aggrega --> F
    E2 -- Salva/Aggrega --> F

    C1 -- Consulta --> F
    C2 -- Consulta --> F
```
## Fluxo Principal

O HaProxy balanceia as conexões entre as instâncias Go.

As requisições /payments são aceitas imediatamente (202 Accepted) e enfileiradas em memória.

Um worker pool de goroutines consome a fila e processa os pagamentos de forma assíncrona.

Cada pagamento é enviado ao processador externo e, em caso de falha, redirecionado para o fallback.

Os resultados (quantidade e valor total) são persistidos em um banco em memória thread-safe (sync.RWMutex), que suporta queries agregadas rápidas.

As consultas /payments-summary buscam diretamente no in-memory DB, sem hits de rede ou disco.

## Stack de Tecnologias

- Linguagem: Go (fasthttp, pools, worker pattern)
- Banco de Dados: In-Memory DB customizado (slice + RWMutex)
- Fila/Mensageria: Channels (chan []byte + chan *PaymentRequest)
- Load Balancer: HaProxy
- Profiling/Optimização: Go pprof + ajustes de GC, pooling e locks

## Diferenciais da Abordagem In-Memory

- 🔥 Menos hops de rede: sem Redis, toda a comunicação é local em memória.
- ⚡ Baixíssima latência: acesso direto a slices com lock fino (RWMutex).
- 🧠 Uso eficiente de memória: pooling de objetos (sync.Pool) e buffers reutilizáveis para evitar GC pressure.
- 🛡️ Thread-safety garantido: acesso concorrente controlado com RWMutex.
- 🧮 Agregação em tempo real: queries de resumo não percorrem grandes estruturas, retornam apenas os agregados.