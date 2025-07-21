# Rinha de Backend 2025

## Tecnologias

- Golang 1.24
- Redis
- Nginx

## Comandos

```bash
# Instalação das libs
$ make setup

# Execução da stack completa (redis + app + nginx)
$ make run
```

## Design da solução

O app possui ambos Producer e Consumer dentro do mesmo pod. 

O Producer recebe as requisições REST e insere os eventos em uma fila que utiliza um Canal Golang com buffer de tamanho parametrizável.

O Consumer roda N goroutines parametrizáveis que consomem do canal, enviando as requisições para o Payment Processor utilizando design de Circuit Breaker.

Devido ao padrão de Circuit Breaker, a rota de healthcheck dos Payment Processors foi totalmente ignorada, deixando por conta do CB decidir qual o melhor momento de virar o fluxo de acordo com a mecânica do circuito meio aberto.

O resultado das requisições é salvo no Redis para geração dos relatórios.
