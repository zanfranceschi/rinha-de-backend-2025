### Estrutura do Projeto - EAP

<img width="1583" height="1432" alt="image" src="https://github.com/user-attachments/assets/92a07a5c-907a-4a28-8a7a-755a0749ab10" />

### Responsabilidades de Classe:

### 📁 `config/`
### ✅ `WebClientConfig.java`

Configura o `WebClient.Builder` como bean Spring, permitindo injetar e reutilizar em toda a aplicação para chamadas HTTP reativas.

---

### 📁 `controller/`

### ✅ `PaymentController.java`

Classe que expõe os endpoints REST:

- `POST /payments`: recebe um pagamento e o enfileira.
- `GET /payments/summary`: retorna um resumo dos pagamentos processados, com suporte a filtro por data (`from` e `to`).

---

### 📁 `dto/`

### ✅ `PaymentRequest.java`

DTO de entrada no `POST /payments`. Contém:

- `correlationId`: identificador único da transação.
- `amount`: valor da transação.

Método `toProcessorPayload(...)` gera o DTO para envio ao processador, incluindo timestamp.

### ✅ `ProcessorPaymentRequest.java`

DTO usado para enviar os dados do pagamento ao processador, contendo:

- `correlationId`
- `amount`
- `requestedAt`: instante de requisição.

---

### 📁 `model/`

### ✅ `PaymentResult.java`

Classe que representa o resultado do processamento do pagamento, contendo:

- `correlationId`
- `amount`
- `processorType` (DEFAULT ou FALLBACK)
- `fee`
- `success`
- `processedAt`: timestamp do processamento.

### ✅ `ProcessorHealth.java`

Record usado para representar o estado de saúde do processador:

- `failing`: indica se está com falha.
- `minResponseTime`: tempo mínimo de resposta simulado.

### ✅ `ProcessorType.java`

Enum que define os tipos de processadores:

- `DEFAULT`
- `FALLBACK`

---

### 📁 `service/`

### ✅ `PaymentService.java`

- Enfileira os pagamentos (`ConcurrentLinkedQueue`).
- Processa periodicamente os pagamentos com `@Scheduled`.
- Armazena os resultados processados por processador (`Map<ProcessorType, List<PaymentResult>>`).
- Gera o resumo dos pagamentos processados (método `getSummary(...)`).

### ✅ `PaymentProcessorClient.java`

- Decide dinamicamente o melhor processador baseado em taxa e saúde.
- Faz até 3 tentativas com backoff (50ms, 100ms, 150ms).
- Utiliza `WebClient` para enviar a requisição HTTP ao processador.
- Em caso de falha, realiza fallback para o outro processador.
- Retorna um `PaymentResult`.

### ✅ `ConfigService.java`

- Busca e atualiza periodicamente (a cada 5s) a taxa (`fee`) dos processadores consultando o endpoint `/admin/payments-summary`.
- Armazena essas taxas em cache (`Map<ProcessorType, BigDecimal>`).

### ✅ `HealthCheckService.java`

- Verifica a saúde dos processadores a partir do endpoint `/payments/service-health`.
- Armazena o resultado em cache por 5 segundos (`TTL`).
- Utilizado pelo `PaymentProcessorClient` para decisões mais inteligentes.

### ✅ `ProcessorHealthTracker.java`

- Implementa um **circuit breaker leve**:
- Registra falhas e sucessos por processador.
- Após 3 falhas consecutivas, “abre o circuito” e bloqueia o uso do processador por 5 segundos.
- Reabilita automaticamente após esse tempo.


### Funcionalidade x Classe Responsável

- Recebe pagamentos via API REST (POST /payments) - PaymentController
- Enfileira os pagamentos em memória - PaymentService (com ConcurrentLinkedQueue)
- Faz flush periódico da fila - PaymentService (método flush com @Scheduled)
- Escolhe o processador mais barato e saudável - PaymentProcessorClient (método sendToBestProcessor)
- Faz fallback se o processador estiver com falha ou lento - PaymentProcessorClient + ProcessorHealthTracker
- Expõe o resumo dos pagamentos via /payments/summary - PaymentController → PaymentService.getSummary(...)

### Técnicas usadas
- Fila em memória com flush assíncrono
- WebClient com timeout	PaymentProcessorClient
- Retry com backoff (50ms, 100ms, 150ms)
- Circuit Breaker leve (após 3 falhas consecutivas)
- Cache de taxas dos processadores (atualiza a cada 5s)
- Cache de saúde dos processadores (TTL de 5s)
- Testes unitários e de integração

