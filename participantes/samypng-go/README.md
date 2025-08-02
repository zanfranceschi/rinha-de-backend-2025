# Rinha de Backend 2025 - Submissão

## Autor: Samuel Silva (samypng)

## Tecnologias utilizadas
- **Linguagem:** Go
- **Armazenamento/Fila:** Redis
- **Balanceador:** Haproxy
- **Orquestração:** Docker Compose

## Como rodar
1. Suba o docker-compose dos Payment Processors primeiro (conforme instruções do repositório oficial).
2. Depois, suba este compose:
   ```sh
   docker compose up --build
   ```
3. O backend ficará disponível na porta **9999**.

## Sobre a solução
Esta é uma implementação para a Rinha de Backend 2025, focada em processamento de pagamentos com alta concorrência. A solução utiliza **streaming architecture** com **worker pools** para processar pagamentos em tempo real, garantindo máxima eficiência e throughput.

### Arquitetura e Tecnologias:
- **Streaming Architecture**: Processamento contínuo de transações em tempo real
- **Worker Pools**: Grupos de workers dedicados para processamento paralelo de pagamentos
- **Redis**: Utilizado tanto para filas de processamento quanto para cache de alta performance
- **Haproxy**: Load balancer configurado para distribuição inteligente entre duas instâncias da API
- **Go**: Linguagem escolhida pela performance superior em cenários de alta concorrência

O sistema foi projetado para suportar alto volume de transações simultâneas, implementando estratégias avançadas de retry, fallback e recuperação automática para garantir a confiabilidade do processamento de pagamentos mesmo sob carga extrema.

## Repositório do código-fonte
[https://github.com/samypng/samypng-rinha-de-backend-2025](https://github.com/samypng/samypng-rinha-de-backend-2025)

## Contato
- **GitHub:** [@samypng](https://github.com/samypng)
