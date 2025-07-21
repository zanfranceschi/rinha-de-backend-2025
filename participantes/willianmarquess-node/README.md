## Rinha backend 2025 - Nodejs + Fastify + Redis

## Tecnologias utilizadas

- **Runtime/Linguagem** Nodejs 22 / Javascript
- **Banco de Dados** Redis
- **Load Balancer** Nginx

## Contexto

A ideia desse projeto foi utilizar Node.js com JavaScript e Fastify e tem como principal objetivo demonstrar uma arquitetura assíncrona no backend. Cada serviço backend opera de forma independente, criando um worker dedicado para processar operações de maneira e eficiente, para realizar o sincronismo dos dados foi utilizado o Redis como banco de dados.

## Arquitetura

![arch](images/arch.png)

## Repo: [Link](https://github.com/willianmarquess/rinha-back-node-2025)

## Resultados

- Resultado abaixo com MAX_REQUESTS=550, executado localmente.

```json
{
  "participante": "anonymous",
  "total_liquido": 364579.4885440429,
  "total_bruto": 333344.89999999997,
  "total_taxas": 20515.905,
  "descricao": "'total_liquido' é sua pontuação final. Equivale ao seu lucro. Fórmula: total_liquido + (total_liquido * p99.bonus) - (total_liquido * multa.porcentagem)",
  "p99": {
    "valor": "2.7286289999999953ms",
    "bonus": 0.1654274200000001,
    "max_requests": "550",
    "descricao": "Fórmula para o bônus: max((11 - p99.valor) * 0.02, 0)"
  },
  "multa": {
    "porcentagem": 0,
    "total": 0,
    "composicao": {
      "total_inconsistencias": 0,
      "descricao": "Se 'total_inconsistencias' > 0, há multa de 35%."
    }
  },
  "lag": {
    "num_pagamentos_total": 16751,
    "num_pagamentos_solicitados": 16751,
    "lag": 0,
    "descricao": "Lag é a diferença entre a quantidade de solicitações de pagamentos vs o que foi realmente computado pelo backend. Mostra a perda de pagamentos possivelmente por estarem enfileirados."
  },
  "pagamentos_solicitados": {
    "qtd_sucesso": 16751,
    "qtd_falha": 0,
    "descricao": "'qtd_sucesso' foram requests bem sucedidos para 'POST /payments' e 'qtd_falha' os requests com erro."
  },
  "pagamentos_realizados_default": {
    "total_bruto": 294858.3,
    "num_pagamentos": 14817,
    "total_taxas": 14742.915,
    "descricao": "Informações do backend sobre solicitações de pagamento para o Payment Processor Default."
  },
  "pagamentos_realizados_fallback": {
    "total_bruto": 38486.6,
    "num_pagamentos": 1934,
    "total_taxas": 5772.99,
    "descricao": "Informações do backend sobre solicitações de pagamento para o Payment Processor Fallback."
  }
}
```