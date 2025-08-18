# Dinossauro

Mais uma submissão para a [Rinha de Backend 2025](https://github.com/zanfranceschi/rinha-de-backend-2025), desta vez em **Assembly x86_64 + Go**.

## Stack

* Assembly x86_64 HTTP Server (NASM)
* Go 1.25+ Worker
* Redis
* NGINX

## Estratégias

* NGINX com configuração padrão
* **HTTP server escrito em Asssembly x86_64** - sem bibliotecas externas
* Thread pool artesanal implementado em Assembly com 5 threads worker (mas que não funcionou bem sob stress)
* Processamento assíncrono com Go worker + Redis pub/sub
* Armazenamento do resumo de pagamentos no Redis utilizando contadores globais e sorted sets
* Pool de conexões para o Redis no worker Go
* Implementação do protocolo RESP (Redis Serialization Protocol) em Assembly
* Retry automático no worker com backoff configurável

## Arquitetura

Este projeto implementa um **HTTP server em Assembly x86_64** para fins de aprendizado e diversão na rinha. Toda a stack de rede (sockets, parsing HTTP, protocolo Redis) é implementada via syscalls diretos do Linux, sem dependências externas, sem libc.

A implementação foi feita com apoio do Claude Code durante lives no Youtube [no meu canal](https://www.youtube.com/watch?v=aIRUKxMG26o&t=9968s).

O Assembly lida com:
- Criação e gerenciamento de sockets TCP
- Parsing completo de requests HTTP/1.1 (verb, path, headers, body, query parameters)
- Roteamento de endpoints (`POST /payments`, `GET /payments-summary`)
- Comunicação direta com Redis via protocolo RESP

O Go lida com:
- Gerenciamento de conexões com Redis
- Pub/Sub para o Redis
- Retry de requests HTTP
- Processamento assíncrono
- Worker Pool

----

Repositório: [leandronsp/dinossauro](https://github.com/leandronsp/dinossauro)

Github: [leandronsp](https://github.com/leandronsp)

DEV.to: [leandronsp](https://dev.to/leandronsp)

LinkedIn: [leandronsp](https://linkedin.com/leandronsp)

Twitter: [@leandronsp](https://twitter.com/leandronsp)

Bluesky: [@leandronsp](http://bsky.app/leandronsp)

Mastodon: [@leandronsp](https://mastodon.social/@leandronsp)
