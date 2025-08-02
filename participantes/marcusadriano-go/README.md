## Solução

Linguagem utilizada: Go.

Premissa: Todas as requests serão processadas assíncronamente (sem utilizar brokers como kafka, rabbitmq, etc);

### Como???

Utilização de goroutine e channels:

```mermaid
sequenceDiagram
    autonumber
    actor user as "Load test"
    participant backend as "Backend<br>Instance"
    participant internal as "Internal<br>Process"
    participant main_processor as "Payment<br>Processor<br>(Main)"

    user->>backend: payment request
    note over backend: Enqueue payment<br>request
    backend->>user: ok

    backend->>internal: async

    alt success
        internal->>main_processor: POST /payments
        main_processor->>internal: ok
        internal->>backend: finish
    else failure
        internal->>main_processor: POST /payments
        main_processor->>internal: 4XX or 5XX other errors
        note over internal: apply some delay<br>sleep...
        internal->>backend: produce the payment again<br>Go to step 3
    else failure 3 times
        internal->>main_processor: POST /payments
        main_processor->>internal: 4XX or 5XX other errors
        note over internal: apply some delay<br>sleep...
        internal->>backend: produce the payment again<br>Go to step 3 (on fallback queue)
    end
```

### Outras informações

```json
{
    "name": "Marcus Adriano",
    "social": ["hhttps://www.linkedin.com/in/marcusadriano"],
    "source-code-repo": "https://github.com/MarcusAdriano/rinha-de-backend-2025",
    "langs": ["go"],
    "storages": ["postgresql"],
    "messaging": [],
    "load-balancers": ["nginx"]
}
```