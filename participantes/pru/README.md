# Pru

```
 _______  _______          
(  ____ )(  ____ )|\     /|
| (    )|| (    )|| )   ( |
| (____)|| (____)|| |   | |
|  _____)|     __)| |   | |
| (      | (\ (   | |   | |
| )      | ) \ \__| (___) |
|/       |/   \__/(_______)
```

Mais uma submissão para a [Rinha de Backend 2025](https://github.com/zanfranceschi/rinha-de-backend-2025), desta vez em Ruby.

## Stack

* Ruby 3.4+ YJIT
* Redis
* NGINX

## Estratégias

* Load balancing com NGINX, utilizando a configuração com 256 conexões
* HTTP server artesanal utilizando a API de Sockets
* Thread Pool artesanal com uma modesta quantidade de 5 threads
* Processamento assíncrono com Sidekiq/Redis
* Armazenamento do resumo de pagamentos no Redis utilizando Sorted Sets
* Pool de conexões para o Redis
* Sem utilização do healthcheck, preferi adotar uma estratégia fail fast com Backoff linear e timeouts/retries rápidos:
    - 3 tentativas no default com intervalo de 2ms e timeout de 300ms
    - 1 tentativa no fallback com timeout de 100ms
    - Retry padrão do Sidekiq

----

Repositório: [leandronsp/pru](https://github.com/leandronsp/pru)
Github: [leandronsp](https://github.com/leandronsp)
DEV.to: [leandronsp](https://dev.to/leandronsp)
LinkedIn: [leandronsp](https://linkedin.com/leandronsp)
Twitter: [@leandronsp](https://twitter.com/leandronsp)
Bluesky: [@leandronsp](http://bsky.app/leandronsp)
Mastodon: [@leandronsp](https://mastodon.social/@leandronsp)
