# Rinha de Backend 2025

## Stack: Rust com [may](https://github.com/Xudong-Huang/may) para async
Repositorio: https://github.com/not4rt/rinha-2025

## Arquitetura
- HAProxy: Load balancer (porta 9999) distribuindo tráfego entre 2 backends
- Backend1/Backend2: Instâncias HTTP idênticas (porta 8080) para receber pagamentos
- Worker: Processador assíncrono dedicado ao envio para processadores externos
- PostgreSQL: Banco de dados principal com otimizações de performance

## Fluxo de Pagamentos
1. Recepção
- Endpoint /payments recebe PaymentRequest via JSON
- Valida payload e insere na fila (tabela payments)
- Retorna imediatamente

2. Processamento Assíncrono
- Workers consultam fila de pagamentos pendentes
- Algoritmo de seleção de processador baseado em latência
- Fallback automático: se processador principal falha, usa o secundário

3. Health Check
- Monitora saúde dos processadores externos a cada 5 segundos
- Atualiza métricas de latência e disponibilidade
- Influencia decisão de roteamento dos workers