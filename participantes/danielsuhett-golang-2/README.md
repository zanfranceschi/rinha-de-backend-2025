# Minha versão da rinha de backends em Go

## Stack
- Go
- FastHTTP (HTTP Server)
- Redis (Queue & Storage)
- Nginx Load Balancer

## Estratégia
A aplicação tem duas instâncias, que tem cada uma delas uma fila para processar os itens que o load balancer endereça.
O consumo passa por uma camada intermediária que consulta um pseudo circuit breaker que retorna uma cor

* GREEN: Usa o processor default
* YELLOW: Usa o processor fallback
* RED: Recoloca no **começo** da fila.

Recebendo uma cor, ele tentará executar o pagamento no processor definido.

**Sucesso?** Grava o pagamento no mesmo redis que utilizamos para a queue.
**Falha?** Convocamos um método chamado signal, esse método vai chamar o health do processor diferente do que foi tentado.
Se o health retornar ok em até 500ms, encontramos uma nova cor, definimos, retornamos para o signal reenviar o request.
Caso os dois estejam off abre-se um intervalo a cada 5000ms para validar ambos os health.
Caso alguém tente consultar uma cor ou enviar um signal enquanto o loop acontece, a cor retornada é vermelha e os itens voltam para a fila.

## Arquitetura de Comunicação

### Health Check Centralizado
Apenas a **instância 1** (APP_NAME=1) executa health checks dos payment processors:
- Monitora ambos os processors a cada 5 segundos quando receber um sinal de falha, parando depois de se recuperar.
- Determina a cor do circuit breaker (GREEN/YELLOW/RED).
- Comunica o estado via Redis para a instância 2.

### Processamento de Queue
Cada instância processa sua própria fila Redis:
- **Instância 1**: fila `payments:queue:1`
- **Instância 2**: fila `payments:queue:2`
- Ambas consultam o estado do circuit breaker compartilhado no Redis

### Requeue Strategy
- **GREEN/YELLOW**: Processa pagamento no processor adequado
- **RED**: Recoloca item no **início** da fila com delay exponencial
- **Falha no processor**: Aciona signal para verificar health do outro processor

### Workers por Instância
- 5 workers concorrentes por instância processando a fila
- Timeout de 3 segundos por worker para evitar bloqueios
- Backoff exponencial em caso de falhas consecutivas

## Limites de Recursos

```yaml
Total permitido: 1.5 CPU + 350MB RAM

Distribuição:
- nginx: 0.10 CPU + 50MB
- api1: 0.65 CPU + 100MB
- api2: 0.65 CPU + 100MB
- redis: 0.10 CPU + 100MB
```

## Configuração e Deploy

### Pré-requisitos
- Docker e Docker Compose
- Network `payment-processor` disponível

### Executar localmente
```bash
docker compose up --build

# Testar endpoints
curl -X POST http://localhost:9999/payments \
  -H "Content-Type: application/json" \
  -d '{"correlationId": "123e4567-e89b-12d3-a456-426614174000", "amount": 19.90}'

curl http://localhost:9999/payments-summary
```

## Variáveis de Ambiente

```env
APP_PORT=3000
APP_NAME=1 ou 2
REDIS_HOST=redis
REDIS_PORT=6379
PROCESSOR_DEFAULT_URL=http://payment-processor-default:8080
PROCESSOR_FALLBACK_URL=http://payment-processor-fallback:8080
HEALTH_TIMEOUT=500ms
HEALTH_INTERVAL=5s
LATENCY_DIFF_TO_USE_FALLBACK=100ms
```

## Fluxo de Circuit Breaker

### Estados do Circuit Breaker
1. **GREEN**: Default processor saudável e rápido
2. **YELLOW**: Default processor com problemas, usa fallback
3. **RED**: Ambos processors indisponíveis

### Lógica de Decisão
- Monitora latência e disponibilidade de ambos processors
- Troca para fallback se default > fallback + threshold
- Estado RED quando ambos falham ou excedem timeout
- Recuperação automática quando processors voltam a responder

### Signal e Recovery
- Signal dispara health check imediato em caso de falha
- Loop com intervalo a cada 5s quando ambos processors estão down
- Durante recursão, novos pagamentos retornam RED e voltam para fila