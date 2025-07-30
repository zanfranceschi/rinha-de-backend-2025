## Observação sobre código gerado por IA

Todo o projeto foi desenvolvido inteiramente pelo GitHub Copilot, utilizando o modelo GPT-4.1, apenas com direcionamentos feitos por humano. Não houve validações ou alterações manuais de código: todas as implementações, revisões e correções foram realizadas exclusivamente pela IA, seguindo as instruções fornecidas.

## Overview

Este projeto implementa um backend otimizado para o desafio Rinha de Backend 2025, focado em alta disponibilidade e baixa taxa de falhas através de arquitetura resiliente com circuit breakers, retry mechanisms e armazenamento síncrono.

**Participante:** Ronaldo Santana  
**LinkedIn:** [ronaldo-santana](https://www.linkedin.com/in/ronaldo-santana/)  
**Repositório:** [github.com/ronssm/CopiRinhaGo](https://github.com/ronssm/CopiRinhaGo)

## Architecture

- **Linguagem:** Go 1.21 com Fiber v2 framework
- **Storage:** Redis para alta performance
- **Load Balancer:** HAProxy
- **Containerização:** Docker Compose
- **Recursos:** 1.5 CPUs e 350MB de memória total

### Principais Features

- **Circuit Breakers:** Proteção por processador com recovery automático
- **Retry Logic:** Exponential backoff para maior confiabilidade
- **Armazenamento Síncrono:** Consistência garantida antes da resposta
- **Deduplicação:** Cache para evitar processamento duplo
- **Health Checks:** Monitoramento automático dos processadores

## Setup

1. Instale Docker e Docker Compose
2. Clone este repositório: `git clone https://github.com/ronssm/CopiRinhaGo`
3. Suba os Payment Processors primeiro (veja instruções do desafio)
4. Execute: `docker-compose up --build`
5. Acesse via `http://localhost:9999`

## Endpoints

- `POST /payments`: Processa pagamentos com fallback automático
- `GET /payments-summary`: Retorna resumo dos pagamentos processados

## Tecnologias

- **Go 1.21 + Fiber v2**: Backend de alta performance
- **Redis 7**: Storage otimizado com transações
- **HAProxy 2.8**: Load balancer com health checks
- **Docker Compose**: Orquestração de containers

## Como funciona

O sistema utiliza uma arquitetura resiliente com as seguintes características:

- **Circuit Breakers**: Proteção por processador com recovery automático
- **Health Checks**: Monitoramento contínuo dos processadores
- **Request Deduplication**: Cache para evitar processamento duplo
- **Exponential Backoff**: Retry inteligente em caso de falhas
- **Synchronous Storage**: Consistência garantida antes da resposta
- **Connection Pooling**: Reutilização otimizada de conexões

## Troubleshooting

- **Circuit breaker open**: Aguarde reset automático
- **Redis connection errors**: Fallback automático para cache em memória
- **Container startup**: Aguarde sincronização entre serviços

## License

MIT

## Changelog

### Version 3.0 - Architecture Resiliente (2025-07-27)

- **Storage**: Migração PostgreSQL → Redis para melhor performance
- **Framework**: Upgrade para Fiber v2
- **Load Balancer**: Nginx → HAProxy para maior eficiência
- **Fault Tolerance**: Circuit breakers, retry logic e storage síncrono
- **Routes**: Correção para `/payments` e `/payments-summary`

### Version 2.0 - Otimizações de Performance (2025-07-26)

- Seleção inteligente de processadores e timeouts adaptativos
- Pool de conexões otimizado e configurações de banco embarcadas
- Significativa redução na taxa de falhas e inconsistências

### Version 1.x - Funcionalidades Base

- Estrutura inicial com Go, PostgreSQL, Nginx e Docker Compose
- Cache de health-check e lógica de fallback
- Conformidade total com regras do desafio
