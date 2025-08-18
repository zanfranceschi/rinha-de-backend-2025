# 🐦 Pru-ASYNC

```
 _______  _______
(  ____ )(  ____ )|\     /|
| (    )|| (    )|| )   ( |
| (____)|| (____)|| |   | |
|  _____)|     __)| |   | |
| (      | (\ (   | |   | |
| )      | ) \ \__| (___) |
|/       |/   \__/(_______)/ASYNC
```

Mais uma submissão para a [Rinha de Backend 2025](https://github.com/zanfranceschi/rinha-de-backend-2025), desta vez em Ruby.

Fork do PRU DO https://github.com/leandronsp/pru do LeandroSP

Resolvi testar as gem async para ver como performaria sem sidekiq

## Stack

* Ruby 3.4+ YJIT
* Redis
* Traefik

## Estratégias

Load balancing com Traefik
- maxIdleConnsPerHost: 256, keep-alive habilitado
- forwardingTimeouts: dialTimeout 200ms, responseHeaderTimeout 1s, idleConnTimeout 20s
- healthCheck: interval 1s, timeout 300ms
- sem retry no Traefik (middleware de retry desabilitado)

Servidor HTTP com async-http (Async::HTTP::Server)

JobQueue (producer/consumer) com Async
- pool fixo de workers (configurável via QUEUE_CONCURRENCY, ex.: 200)
- buffer/bounded queue com backpressure (capacidade padrão 2048)
- executa no mesmo thread/reactor do HTTP (IO-bound e non-blocking)
Circuit Breaker in-memory

- janela: 5s; abre quando falhas na janela > 5 (threshold padrão 5)

Armazenamento no Redis
- resumo em Sorted Set (payments_log)
- chave processed:<correlationId> para deduplicação de requisições
Async Redis e Async HTTP (um cliente Redis compartilhado por processo)

Estratégia de tentativas (no app, não no proxy)

- default: 2 tentativas, intervalo ~1–2ms entre elas, timeout 200ms
- fallback: 1 tentativa, timeout 80ms
- em caso de falha total: até 2 novas tentativas com backoff linear (1s, 2s)

## Curiosidade no repo

Existe uma versão de Proxy puro em Async HTTP mas com traefik consegui um controle
mais fino

----

Repositório: [renatovico/pru-async](https://github.com/renatovico/pru-async)
Github: [renatovico](https://github.com/renatovico)
