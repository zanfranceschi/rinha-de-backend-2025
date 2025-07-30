# Rinha de Backend 2025 - Submissão Go

## Tecnologias utilizadas
- **Linguagem:** Go
- **Mensageria:** NATS JetStream
- **Balanceador:** HAProxy
- **Orquestração:** Docker Compose
- **Armazenamento:** Memória (worker de persistência opcional para banco de dados)

## Como rodar

1. Suba o docker-compose dos Payment Processors primeiro (se aplicável, conforme instruções do repositório oficial do desafio).
2. Depois, suba este compose:

   ```sh
   docker-compose up --build

3. O backend ficará disponível na porta 9999.

## Sobre a Solução

O backend foi desenvolvido em Go, processando pagamentos de forma assíncrona usando NATS JetStream para fila de mensagens.
O HAProxy faz o balanceamento entre duas instâncias da API (payment-api-1 e payment-api-2), utilizando roundrobin.

O processamento é realizado por um worker dedicado, que armazena e gerencia os dados em memória, buscando máxima velocidade e baixíssima latência, sem uso de banco de dados externo.
Existe um worker opcional de persistência, já pronto para integração futura, caso deseje salvar em banco de dados.

## Lógica de seleção de processador
O worker pode processar usando dois processadores: default e fallback.
A preferência é sempre pelo processador default, que só deixa de ser usado se:

- Estiver falhando/fora do ar;

- estiver muito mais lento (mais de 3x mais lento e acima de 100ms) em relação ao fallback.

Essa lógica garante alta disponibilidade e throughput, mas sempre prioriza o default.
O worker monitora continuamente ambos os processadores e alterna automaticamente quando necessário.

## Repositório do código-fonte

https://github.com/ArthurSeus/rinha2025