# Rinha de Backend 2025 - PHP & Swoole

## Sobre o Desafio

Desenvolver uma API que intermedia pagamentos entre dois processadores. Ganha quem lucrar mais, processar mais rápido e ter consistência. Link para o desafio: [Rinha de Backend 2025](https://github.com/zanfranceschi/rinha-de-backend-2025)

### Fluxo de Processamento

1.  **Recebimento**: Um Load Balancer (Nginx) recebe as requisições HTTP e as distribui em modo Round Robin entre duas instâncias da aplicação PHP.
2.  **Enfileiramento Rápido**: A API responde ao cliente o mais rápido possível e enfileira o pagamento em uma fila no Redis para processamento assíncrono.
3.  **Processamento Assíncrono**: Workers (em PHP/Swoole) consomem a fila de pagamentos de forma contínua.
4.  **Lógica de Fallback Inteligente**: O worker verifica a latência dos processadores de pagamento e utiliza uma lógica de custo-benefício.
5.  **Auditoria**: O sistema persiste um registro de todas as transações processadas com sucesso, que podem ser consultadas através de um endpoint de resumo.

## Tecnologias

### Backend

-   **Linguagem**: PHP 8.4
-   **Runtime Assíncrono**: Swoole
-   **Banco de Dados / Fila**: Redis

### Infraestrutura

-   **Containerização**: Docker
-   **Orquestração**: Docker Compose
-   **Load Balancer**: Nginx

## Recursos (Limite: 1.5 CPU + 350MB RAM)

| Serviço | CPU   | Memória   | Função                               |
| :------ | :---- |:----------| :----------------------------------- |
| `nginx` | 0.1   | 30MB      | Load Balancer                        |
| `app1`  | 0.6   | 120MB     | API Server + Worker (PHP/Swoole)     |
| `app2`  | 0.6   | 120MB     | API Server + Worker (PHP/Swoole)     |
| `cache` | 0.2   | 80MB      | Redis (Fila e Armazenamento)         |
| **Total** | **1.5** | **350MB** | ✅                                   |
