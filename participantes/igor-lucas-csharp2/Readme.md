# 🐓 Rinha de Backend 2025 (.NET Edition)

Este repositório contém minha implementação em C#/.NET para o [Rinha de Backend 2025](https://github.com/zanfranceschi/rinha-de-backend-2025). O objetivo é maximizar o lucro financeiro roteando pagamentos entre dois serviços de processamento (default e fallback), lidando com instabilidades e garantindo consistência dos dados via endpoint de resumo.

## Arquitetura

Optou-se por uma arquitetura mais distribuída para melhor distribuição de recursos, somando com a publicação AOT(Ahead of Time) do .NET 9, visando alta performance e baixa latência. A solução utiliza Docker Compose para orquestrar os serviços, garantindo isolamento e escalabilidade.
O sistema é composto pelos seguintes serviços:

- **API Service (.NET 9)**: Recebe requisições HTTP e enfileira pagamentos no Redis.
- **Worker Assíncrono**: Consumidores em background processam pagamentos da fila Redis.
- **Health Manager**: Verifica periodicamente a saúde dos processadores e atualiza o status em memória.
- **PostgreSQL**: Persiste registros de pagamentos para auditoria e geração de relatórios.
- **Redis**: Backend para fila de pagamentos e cache de métricas de saúde.
- **NGINX Load Balancer**: Distribui o tráfego HTTP entre instâncias da API.
- **Docker Compose**: Orquestra todos os containers, incluindo rede externa para os processadores de pagamento.

## Decisões de Projeto

### Processamento Assíncrono
Pagamentos recebidos via `POST /payments` são enfileirados no Redis e processados por workers em background, aumentando throughput e resiliência.

### Roteamento Dinâmico por Saúde
O sistema monitora `/payments/service-health` dos processadores e sempre evita enviar para serviços marcados como "failing". O roteamento prioriza o processador com menor latência e alterna para fallback se necessário.

### Persistência & Resumo
Pagamentos bem-sucedidos são gravados no PostgreSQL. O endpoint `GET /payments-summary` retorna totais por processador, com filtros opcionais de data.

### Containerização & Limites de Recursos
- Dockerfile multi-stage gera uma imagem enxuta para produção.
- Docker Compose define limites de CPU/memória conforme o desafio.
- Rede bridge e integração com serviços externos de pagamento.

## Endpoints da API

| Método | Caminho                | Descrição                                                        |
|--------|------------------------|------------------------------------------------------------------|
| POST   | `/payments`            | Enfileira novo pagamento. Retorna HTTP 200 se válido.            |
| GET    | `/payments-summary`    | Retorna resumo agregado dos pagamentos, com filtros opcionais.   |
| POST   | `/purge-payments`      | Limpa todos os registros de pagamento do banco.                  |

## Como Executar

### 1. Configure os Processadores de Pagamento

Suba os processadores externos conforme documentação do desafio.

### 2. Build e Deploy

```sh
docker-compose up -d --build
```

### 3. Verifique os Serviços

- API: `http://localhost:5000`
- NGINX: `http://localhost:9999`
- Logs: `docker-compose logs -f`

## Conclusão

Esta solução busca equilibrar desempenho e resiliência, utilizando processamento assíncrono e roteamento dinâmico baseado em saúde dos serviços, visando maximizar lucro e atender aos requisitos de latência do desafio.
