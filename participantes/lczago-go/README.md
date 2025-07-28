# Rinha de Backend 2025 - Go & Nats

Cada requisição de payment é inserida na fila de processamento e
consumidor recebe o objeto, enviando para os processors e salvando no banco.

Requisição de summary busca no banco as informações atualizadas.

## Tecnologias Utilizadas

- [Go](https://go.dev/)
- [Fiber](https://gofiber.io/)
- [Nats](https://nats.io/) — JetStream para fila de processamento
- [Postgres](https://www.postgresql.org/)

## [Source code](https://github.com/lczago/rinha-25-go-nats)