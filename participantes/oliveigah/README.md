# Resumo

Implementação utilizando apenas elixir + haproxy. Sem banco de dados externos, sem fila externa. Suportando até 4000 VUs com p99 abaixo de 2ms.

A fila e o armazenamento foram implementados diretamente na app utilizando ETS (erlang term storage).

codigo fonte: https://github.com/oliveigah/rinha_backend_v3

## Resultados 550 vus

```json
{
  "participante": "anonymous",
  "total_liquido": 373214.43141426024,
  "total_bruto": 333305.10000000003,
  "total_taxas": 21622.345,
  "descricao": "'total_liquido' é sua pontuação final. Equivale ao seu lucro. Fórmula: total_liquido + (total_liquido * p99.bonus) - (total_liquido * multa.porcentagem)",
  "p99": {
    "valor": "1.129117599999997ms",
    "bonus": 0.19741764800000006,
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
    "num_pagamentos_total": 16749,
    "num_pagamentos_solicitados": 16749,
    "lag": 0,
    "descricao": "Lag é a diferença entre a quantidade de solicitações de pagamentos vs o que foi realmente computado pelo backend. Mostra a perda de pagamentos possivelmente por estarem enfileirados."
  },
  "pagamentos_solicitados": {
    "qtd_sucesso": 16749,
    "qtd_falha": 0,
    "descricao": "'qtd_sucesso' foram requests bem sucedidos para 'POST /payments' e 'qtd_falha' os requests com erro."
  },
  "pagamentos_realizados_default": {
    "total_bruto": 283734.2,
    "num_pagamentos": 14258,
    "total_taxas": 14186.710000000001,
    "descricao": "Informações do backend sobre solicitações de pagamento para o Payment Processor Default."
  },
  "pagamentos_realizados_fallback": {
    "total_bruto": 49570.9,
    "num_pagamentos": 2491,
    "total_taxas": 7435.635,
    "descricao": "Informações do backend sobre solicitações de pagamento para o Payment Processor Fallback."
  }
}
```

## Resultados 4000 vus

```json
{
  "participante": "anonymous",
  "total_liquido": 2658989.073782658,
  "total_bruto": 2425272.7,
  "total_taxas": 173473.27500000002,
  "descricao": "'total_liquido' é sua pontuação final. Equivale ao seu lucro. Fórmula: total_liquido + (total_liquido * p99.bonus) - (total_liquido * multa.porcentagem)",
  "p99": {
    "valor": "1.958571969999999ms",
    "bonus": 0.18082856060000002,
    "max_requests": "4000",
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
    "num_pagamentos_total": 121873,
    "num_pagamentos_solicitados": 121873,
    "lag": 0,
    "descricao": "Lag é a diferença entre a quantidade de solicitações de pagamentos vs o que foi realmente computado pelo backend. Mostra a perda de pagamentos possivelmente por estarem enfileirados."
  },
  "pagamentos_solicitados": {
    "qtd_sucesso": 121873,
    "qtd_falha": 0,
    "descricao": "'qtd_sucesso' foram requests bem sucedidos para 'POST /payments' e 'qtd_falha' os requests com erro."
  },
  "pagamentos_realizados_default": {
    "total_bruto": 1903176.3,
    "num_pagamentos": 95637,
    "total_taxas": 95158.815,
    "descricao": "Informações do backend sobre solicitações de pagamento para o Payment Processor Default."
  },
  "pagamentos_realizados_fallback": {
    "total_bruto": 522096.4,
    "num_pagamentos": 26236,
    "total_taxas": 78314.46,
    "descricao": "Informações do backend sobre solicitações de pagamento para o Payment Processor Fallback."
  }
}
```
