# 🐦 Pru-ASYNC-v2

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


Fork do PRU DO https://github.com/leandronsp/pru do LeandroSP

Resolvi testar as gem async para ver como performaria sem sidekiq

Tunning forte no pods + camada para defer caso o request de timeout no payments

Nesta versao fui para sysctl e uma camada de 3 queus

## Stack

* Ruby 3.4+ YJIT
* Redis
* Nginx
* Falcon

## Estratégias

Load balancing com Nginx


## Curiosidade no repo

Existe uma versão de Proxy puro em Async HTTP mas com traefik consegui um controle
mais fino

----

Repositório: [renatovico/pru-async](https://github.com/renatovico/pru-async)
Github: [renatovico](https://github.com/renatovico)
