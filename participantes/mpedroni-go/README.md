# mpedroni-go

Versão inicial, focada apenas em criar uma implementação minimamente satisfatória, elegível para participar do desafio. A ideia é que essa implementação sirva como base para evoluções futuras, tanto em termos de performance quanto de resiliência e consistência de dados.

## Abordagem para processamento dos pagamentos

Os pagamentos são enfileirados e processados por workers em background. Cada pagamento é enviado ao processor default e, caso o pagamento falhe, tenta-se novamente. O processor de fallback não é utilizado nesta primeira versão.

Tanto a fila (em memória) quanto os workers foram implementados utilizando apenas os componentes nativos do Go (channels, goroutines, syncs, etc).

## Tecnologias utilizadas

- **Linguagem:** Go
- **Armazenamento:** PostgreSQL
- **Gerenciamento de filas e workers:** Implementação nativa em Go
- **Balanceamento de carga:** Nginx

## Código fonte

<https://github.com/mpedroni/rinha-de-backend-2025-go>
