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
* NGINX

## Estratégias

* Load balancing com NGINX, utilizando a configuração com 256 conexões e keap-alive e proxy-timeout
* HTTP do ASYNC-HTTP
* JobQueue ASYNC com 200 workers em paralelo ao HTTP Server
* Circuit Breaker de 5 segundos com falha em 5 segundos
* Armazenamento do resumo de pagamentos no Redis utilizando Sorted Sets
* Async Redis/Async HTTP
* Sem utilização do healthcheck:
    - 2 tentativas no default com intervalo de 2ms e timeout de 300ms
    - 1 tentativa no fallback com timeout de 100ms
    - 2 retries em progressão geometrica de 2

----

Repositório: [leandronsp/pru](https://github.com/renatovico/pru-async)
Github: [leandronsp](https://github.com/renatovico)
