# Rinha 2025 - Processamento de Pagamentos

[![Repositório no GitHub](https://img.shields.io/badge/GitHub-Repo-blue?logo=github)](https://github.com/gaoliveira21/rinha-2025)

## Descrição

Este projeto implementa um sistema de processamento de pagamentos desenvolvido em Go, utilizando PostgreSQL como banco de dados e Docker para orquestração dos serviços.

## Tecnologias

- Golang
- PostgreSql
- Nginx

## Estratégia de Processamento de Pagamentos

De forma geral as requisições para a rota POST /payments são recebidas e enviadas para um fila para processamento assíncrono, em caso de falha ou indisponibilidade dos serviços
de pagamento, é utilizado uma estratégia de retentativas, ao esgotar a quantidade de retentativas o pagamento é persistido na base de dados para ser processado posteriormente quando houver
algum serviço disponível. Segue abaixo uma explicação mais detalhada do processo:

- **Processador Default e Fallback:**
  - O sistema utiliza dois processadores de pagamento: um principal (default) e um de fallback.
  - Antes de processar um pagamento, o sistema verifica a saúde do processador default. Caso esteja saudável, o pagamento é processado por ele.
  - Se o processador default estiver indisponível, o sistema tenta processar o pagamento pelo processador de fallback.
  - Caso ambos estejam indisponíveis, o pagamento é re-enfileirado para tentativa futura.

- **Fila e Dispatcher:**
  - Os pagamentos são enfileirados e processados por workers controlados por um dispatcher, respeitando limites de concorrência para otimizar o uso de CPU e conexões com o banco.
  - O dispatcher utiliza canais para controlar o fluxo de jobs e garantir que o sistema não sobrecarregue os recursos disponíveis.

- **Reprocessamento de Falhas:**
  - Pagamentos que falham após múltiplas tentativas são armazenados em uma fila de falhas no banco de dados.
  - Um processo dedicado monitora essa fila e tenta reprocessar os pagamentos assim que os processadores voltam a ficar disponíveis.

- **Persistência e Consistência:**
  - Todas as operações de pagamento são realizadas dentro de transações para garantir a consistência dos dados.
  - O sistema utiliza índices nos campos de data para otimizar consultas de resumo e histórico de pagamentos.

## Como Executar

1. Clone o repositório:
   ```sh
   git clone https://github.com/gaoliveira21/rinha-2025.git
   cd rinha-2025
   ```
2. Suba os serviços com Docker Compose:
   ```sh
   docker-compose up --build
   ```
3. Acesse a API via NGINX na porta 9999:
   - `http://localhost:9999`

## Endpoints Principais

- `POST /payments` - Processa um novo pagamento
- `POST /purge-payments` - Remove todos os pagamentos
- `GET /payments-summary` - Retorna um resumo dos pagamentos
- `GET /health` - Verifica a saúde do serviço

## Observações
- Os limites de CPU e memória são configurados no `docker-compose.yaml` para garantir que o sistema opere dentro dos recursos definidos.
- O pool de conexões com o banco e o número de workers são ajustados para evitar sobrecarga e garantir alta performance.

## Autor
- Gabriel Oliveira
