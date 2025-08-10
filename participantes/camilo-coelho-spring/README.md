# 🥊 Figth - Spring Boot Application

## 📋 Visão Geral

## ⚡ Estratégia de Alta Eficiência e Throughput

Esta seção descreve as escolhas que permitem atingir ~500 TPS com orçamento reduzido de CPU/memória.

### Princípios
- Minimalismo de trabalho síncrono: o caminho HTTP faz o mínimo necessário e retorna 202 rapidamente.
- Assíncrono e em lote: o processamento pesado ocorre em background, em lotes, reduzindo roundtrips ao DB.
- Stateless + escala horizontal: nenhuma afinidade de sessão; basta adicionar instâncias atrás do NGINX.
- Resiliência: timeouts curtos e fallback explícito para serviços externos.
- Eficiência de CPU/memória: binário nativo (GraalVM), logs contidos, pool e timeouts calibrados.

### Como está implementado
- Caminho de escrita enxuto
  - `PaymentController` delega a `PaymentService.saveToQueue(...)` que persiste em `PaymentQueue` e retorna.
  - Resposta 202 (aceito) remove o cliente do caminho crítico.
- Processamento assíncrono
  - `@Async("taskExecutor")` em `PaymentService` (ver `AsyncConfig`) para liberação do thread HTTP.
  - `PaymentQueueProcessorService` busca lotes (padrão: 100) e chama o processador principal e, em falha, o fallback.
- JPA/Hibernate otimizado
  - `hibernate.jdbc.batch_size=100`, `order_inserts=true`, `order_updates=true` em `application-dev.yml`.
  - Batching reduz syscalls e melhora cache/localidade no DB.
- Pool de conexões (HikariCP)
  - Limites e timeouts definidos (pool size, idle, max lifetime, connection test) para evitar vazamentos e pausas longas.
- Clientes HTTP (Feign)
  - Timeouts de conexão/leitura curtos, URLs de processador e fallback configurados; logger básico para baixo overhead.
- Threads leves
  - Suporte a virtual threads (`spring.threads.virtual.enabled=true`) opcional para alta concorrência com poucas alocações.
- Binário nativo
  - Dockerfile usa GraalVM Native Image, reduzindo RSS e tempo de cold start, cabendo no orçamento de memória.
- Logging econômico
  - Níveis INFO/ERROR nos pacotes críticos e possibilidade de `LOG_LEVEL=OFF` em container para produção.

### Padrões de estado e resiliência
- Estados principais
  - Fila: `Q` (queued), processamento em progresso e reclassificação por limpeza de stale, Os itens em processamento vão para o estado `P` (processando), quando falham retornam para `Q`, e após processados vão para `C` (comitado)
  - Pagamento: `D` (processador principal), `F` (fallback), DLQ em falhas persistentes.
- Fallback explícito
  - Em erro no processador principal, chamada ao fallback; em nova falha, marcação de erro e retenção para inspeção.
- Limpeza de itens travados
  - `StaleProcessingCleanupService` devolve itens com processamento antigo para `Q` e reprocessamento.

### Operação e tuning
- Aumentar throughput
  - Escalar horizontalmente adicionando instâncias atrás do NGINX.
  - Ajustar `hibernate.jdbc.batch_size` e o tamanho do lote do `PaymentQueueProcessorService` conforme latência do DB.
- Reduzir latência
  - Ajustar timeouts do Feign e do pool Hikari; manter conexões HTTP keep-alive via NGINX.
- Reduzir uso de memória/CPU
  - Manter logs em nível mínimo, usar imagem nativa, revisar limites do pool e número de threads do `taskExecutor`.
- Observabilidade
  - Actuator exposto (health, info, metrics, env). Usar métricas para guiar tuning de batch/pool/threads.

### Considerações
- Consistência eventual: respostas 202 indicam que o processamento ocorre depois; consumidores devem tolerar atraso curto.
- Correlação: `correlationId` nos DTOs permite rastreio ponta-a-ponta e facilita id de duplicatas no processador externo. 