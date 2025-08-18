# Rinha de Backend 2025 - Bundemais

Se tem Bun e é bom, é bun demais.

###### Tecnologias usadas

- Linguagem: TypeScript (Bun como runtime)
- Framework: Elysia
- Fila: Redis
- Armazenamento: Redis
- Balanceador de carga: Nginx
- Orquestração: Docker
- Documentação: Swagger

###### Sobre a solução

O pacote `node:cluster` foi usado para orquestrar quantos processos forem possíveis criar em uma máquina. O processo principal inicializa o servidor HTTP, feito com Elysia, e os processos filho inicializam os workers.

O servidor escuta as rotas `POST /payments` e `GET /payments-summary`, que têm as entradas validadas automaticamente. Além disso, ele gera a documentação da referência da API automaticamente usando Swagger e os modelos de dados definidos.

A rota `POST /payments` enfileira o pagamento e responde `202 ACCEPT` o mais rápido possível.

A rota `GET /payments-summary` busca os pagamentos no Redis, filtrando adequadamente com base nos query params `to` e `from`.

Enquanto isso, os processos filho executam um loop infinito que:

- Tira o primeiro pagamento da fila de "pagamentos" e coloca na fila de "processando"
- Tenta processar o pagamento no processador padrão, caso não seja possível tenta no processador fallback
- Remove da fila
- Salva um hash dizendo que o pagamento foi realizado

O Redis está sendo usado tanto para armazenar os dados quanto para enfileirar os pagamentos.

O Nginx é utilizado para distribuir os pedidos entre as duas instâncias da API bundemais.

## Como rodar

Suba os contêineres dos processadores de pagamento da Rinha

```sh
# dentro de rinha-de-backend-2025/payment-processor
docker compose up -d
```

Suba os contêineres do `bundemais`

```sh
# dentro de bundemais
docker compose up -d
```

Acesse a documentação gerada pelo Swagger em [localhost:9999](http://localhost:9999/swagger).

## Aprendizado

Aprendi um pouquinho sobre filas e comandos do Redis, instruções do `docker-compose.yml`, como construir uma imagem docker com GitHub Actions seguindo semantic releases, como usar o pacote `node:cluster`, como usar o Elysia e gerar documentação automaticamente com Swagger...

Foi uma pequena jornada cheia de aprendizados.

Deixo aqui meu agradecimento a incrível iniciativa, obrigado!

## Repositório

https://github.com/kauefraga/bundemais
