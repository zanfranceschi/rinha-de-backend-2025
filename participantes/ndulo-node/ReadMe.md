# Rinha de Backend 2025 - Solução

Esta é uma solução para o desafio da Rinha de Backend 2025, implementando um serviço de processamento de pagamentos com fallback e consistência de dados.

## Tecnologias Utilizadas

- Node.js (v24)
- fastify.js
- PostgreSQL
- Nginx (load balancing)
- Docker

## Arquitetura

O sistema consiste em:
- 2 instâncias do serviço de aplicação (app1, app2)
- 1 instância de Nginx como load balancer
- 1 instância de PostgreSQL como banco de dados

## Como Executar

1. Certifique-se que os serviços de Payment Processor estão rodando
2. Execute `docker-compose up --build`

## Estratégias Implementadas

- Health check inteligente com cache
- Fila de processamento com workers
- Fallback automático para o segundo processador
- Armazenamento local de transações não processadas
- Balanceamento de carga com Nginx
- Validação rigorosa de entradas
- Tratamento de erros resiliente
