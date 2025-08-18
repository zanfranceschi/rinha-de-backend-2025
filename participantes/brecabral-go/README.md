# Rinha de Backend 2025

Submissão para o desafio da Rinha de Backend 2025.

## Arquitetura e Tecnologias

A solução proposta utiliza uma arquitetura assíncrona, enfileirando as requisições recebidas e as processando com *workers*, sempre tentando utilizar o `default processor`, em caso de falha com status `5xx` tenta-se o `fallback processor`, caso ocorra novamente uma falha com status `5xx` a transação volta para a fila, outro tipo de falha descarta a transação.

### Go
Utilizado para o desenvolvimento das instancias do backend, facilitando a construção de concorrencia via *workers*.

### PostgreSQL
Para persistir as transações, que podem ser consultadas posteriormente através do endpoint `/payments-summary`.

### Redis: 
Servindo como um sistema de mensageria para enfileirar as requisições de transação recebidas. 

## Código Fonte

Disponível em: [rinha-2025](https://github.com/brecabral/rinha-2025)