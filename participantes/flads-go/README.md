# Rinha de Backend 2025 - Go

[Aqui](https://github.com/flads/rinha25/tree/go) você pode acessar o código fonte do projeto.

##### Tecnologias utilizadas:

* [Go](https://go.dev/) - Linguagem de programação.
* [Fast HTTP](https://github.com/valyala/fasthttp) - Servidor HTTP de alto desempenho em Go.
* [Redis](https://redis.io/) - Banco de dados em memória.
* [Nginx](https://nginx.org/) - Proxy reverso e balanceador de carga.

##### Arquitetura dos Serviços

- **HAProxy**: Responsável por receber as requisições HTTP e atuar como **load balancer**, distribuindo as solicitações entre as duas instâncias da API via soquetes Unix.
- **APIs (api-1 e api-2)**: Gerenciam as requisições de pagamento, enviando os dados para uma fila ordenada no Redis.
- **Worker (worker-1 e worker-2)**: Executa continuamente, consumindo as requests da fila do Redis e processando os pagamentos, enviando requisições aos servidores externos de processamento.
- **Redis**: Banco de dados em memória utilizado como meio de comunicação entre as apis e os workers.
