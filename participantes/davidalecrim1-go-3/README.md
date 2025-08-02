# Rinha de Backend 2025 - Submissão

## Tecnologias utilizadas
- **Linguagem:** Go
- **Armazenamento/Fila:** Redis
- **Balanceador:** Extreme
- **Orquestração:** Docker Compose

## Sobre a solução
O backend foi desenvolvido em Go usando o web framework Fiber com Sonic para encoding/decoding de JSON com ultra velocidade. Ele tem um deployment independente para as APIs e outro para o worker processar pagamentos de forma assincrona. Os pagamentos são adicionados num Redis e processados pelo worker somente no endpoint default para minimizar os custos do fallback.

Essa versão acompanha um Load Balancer customizado (chamado de Extreme) criado usando Go e Fast HTTP para substituir o Nginx e reduzir a latencia da API ao extremo.

## Repositório
[https://github.com/davidalecrim1/rinha-with-go-2025/tree/feature/redis-only-default](https://github.com/davidalecrim1/rinha-with-go-2025/tree/feature/redis-extreme)