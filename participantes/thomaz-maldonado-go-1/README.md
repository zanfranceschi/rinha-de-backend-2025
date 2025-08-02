# Rinha de Backend 2025 - Minha Solução

Este repositório contém a minha submissão para a [Rinha de Backend 2025](https://github.com/zanfranceschi/rinha-de-backend-2025).

A solução foi desenvolvida com foco em alta performance, resiliência e consistência, utilizando uma arquitetura assíncrona baseada em fila para garantir baixa latência (p99) no endpoint de recebimento de pagamentos.

## Tecnologias Utilizadas

* **Linguagem:** Go (Golang)
* **Framework Web:** [Fiber](https://gofiber.io/) - Escolhido por seu alto desempenho e baixo overhead.
* **Banco de Dados / Fila:** [Redis](https://redis.io/) - Utilizado como uma fila de jobs (`LIST`) para o processamento assíncrono de pagamentos e para cache de estado (`STRING`).
* **Load Balancer:** [Nginx](https://www.nginx.com/) - Responsável por distribuir a carga entre as duas instâncias da API.
* **Serialização JSON:** [Sonic](https://github.com/bytedance/sonic) - Um decoder/encoder JSON de alta performance para otimizar o parsing de requisições.
* **Conteinerização:** Docker e Docker Compose.

## Arquitetura

A arquitetura foi desenhada para desacoplar o recebimento da requisição do seu processamento, visando a máxima velocidade de resposta na API.

1.  **Load Balancer (Nginx):** Recebe todas as requisições na porta `9999` e as distribui entre as instâncias da API.
2.  **API (Go/Fiber):**
    * **`POST /payments`**: Valida a requisição, incrementa os contadores de `summary` no Redis (abordagem de "incremento otimista") e enfileira a tarefa de pagamento em uma lista no Redis. Responde `202 Accepted` quase que instantaneamente.
    * **`GET /payments-summary`**: Lê os contadores consolidados diretamente do Redis, garantindo uma resposta rápida e consistente.
3.  **Fila (Redis):** Uma lista (`LIST`) no Redis atua como um buffer de tarefas (`payment_jobs`), garantindo que nenhuma requisição seja perdida.
4.  **Workers (Goroutines):** Um conjunto de workers (goroutines concorrentes) consome as tarefas da fila do Redis em segundo plano.
    * Cada worker verifica a saúde dos processadores de pagamento (com cache em Redis).
    * Decide qual processador usar (`default` ou `fallback`).
    * Executa a chamada HTTP para o processador.
    * Em caso de falha no processador `default`, o worker realiza uma transação de compensação nos contadores do Redis, movendo a contagem do `default` para o `fallback`, garantindo a consistência do `summary`.




