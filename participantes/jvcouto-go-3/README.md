# jvpayments

## Tecnologias utilizadas

- **Linguagem**: Go
- **Servidor HTTP**: fasthttp
- **Persistência**: Redis
- **Load Balancer**: nginx
- **Queue**: Redis

## Estratégia

A API foi desenvolvida em Golang, utilizando o fasthttp para garantir alto desempenho no processamento de requisições. O processamento dos pagamentos ocorre de forma assíncrona, por meio de uma worker pool. Em caso de falhas no processamento, os pagamentos são automaticamente enfileirados e reprocessados com um número máximo de tentativas (retries). Em segundo plano, um serviço de health check monitora a disponibilidade dos serviços de pagamento, auxiliando no processo de eleição dinâmica do serviço a ser utilizado. Após a confirmação de um pagamento bem-sucedido, os dados e valores são armazenados no Redis.

## Repositório

[Repositorio do projeto](https://github.com/jvcouto/jvpayments)