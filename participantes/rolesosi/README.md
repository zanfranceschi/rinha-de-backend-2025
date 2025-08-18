# rdb-2025-try
Repositório para a tentativa de participação na rinha de backend 2025.

## Visão geral
Esse projeto implementa um serviço de processamento de pagamentos com endpoints de API, processos worker de processamento e capacidade de balanceamento de carga.

## Variaveis de Ambiente

O projeto utiliza variáveis de ambiente para configuração. Essas podem ser definidas no arquivo `.env` ou diretamente no `docker-compose.yml`.

### Variaveis de Ambiente Principais

| Variavel | Descrição | Default |
|----------|-------------|---------|
| `INSTANCE` | Identificador de instância para serviços de API | "unknown" |
| `REDIS_URL` | String de Conexao Redis | "redis://redis:6379/0" |
| `DEFAULT_PROCESSOR_URL` | URL para default payment processor | (obrigatorio) |
| `FALLBACK_PROCESSOR_URL` | URL para fallback payment processor | (obrigatório) |

### Melhoria de Performance

| Variavel | Descrição | Default |
|----------|-------------|---------|
| `WORKERS` | Number of Uvicorn workers per API instance | 1 |
| `BATCH_SIZE` | Number of payments to process in a batch | 10 (API), 8 (Worker) |
| `MAX_RETRIES` | Maximum retry attempts for payment processors | 3 |
| `BACKOFF_BASE` | Base time (seconds) for exponential backoff | 0.5 |
| `POLL_TIMEOUT` | Timeout (seconds) for Redis BLPOP operation | 5 |
| `HTTP_TIMEOUT` | Timeout (seconds) for HTTP requests | 2.5 |

### Confguração Avançada

| Variavel | Descrição | Default |
|----------|-------------|---------|
| `LOG_LEVEL` | Logging level (DEBUG, INFO, WARNING, ERROR, CRITICAL) | WARNING |
| `REDIS_MAX_CONNECTIONS` | Maximum number of Redis connections | 10 |
| `REDIS_HEALTH_CHECK_INTERVAL` | Interval (seconds) for Redis health checks | 30.0 |
| `HTTP_CONNECTION_LIMIT` | Maximum number of HTTP connections | 100 |
| `HTTP_CONNECTION_LIMIT_PER_HOST` | Maximum number of HTTP connections per host | 20 |

## Constante de Recursoa

O servico foi desenvolvido para operar dentro dos seguintes limites de recursos estabelecidos pelo desafio:
- CPU total: 1.5 cores
- Memoria total: 350MB

### Alocacao de Recuros

| Servico | CPU | Memoria |
|---------|-----|--------|
| nginx | 0.03 | 15MB |
| api1 | 0.50 | 85MB |
| api2 | 0.50 | 85MB |
| worker | 0.35 | 85MB |
| redis | 0.12 | 80MB |

## Optimizando Performance

1. **API Services**: Configura os `WORKERS` baseado na CPU e memoria disponivel. Comece com 1 worker e aumente se os recursos permitirem.

2. **Worker Service**: Ajuste o `BATCH_SIZE` para encontrar o equilíbrio correto entre throughput e latência. Valores menores reduzem inconsistências, mas podem diminuir o throughput.

3. **Retry Logic**: Configure `MAX_RETRIES` e `BACKOFF_BASE`  para balancear entre confiabilidade e responsividade.

4. **Memory Usage**: Monitore o uso de memória e ajuste a alocação de recursos conforme necessário.

## Ratreio de Consistencia

Este serviço implementa um sistema de rastreio de consistência para garantir que todos os pagamentos sejam processados corretamente. Para verificar inconsistências durante o teste:

```bash
curl http://localhost:9999/consistency-check
```

Gera um relatorio com qualquer pagamento que foi enviado mas noa processado, ou processado mas nao enviado.

