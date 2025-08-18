# Paulo Sérgio - Rinha 2025

Este repositório contém a minha submissão para a **Rinha de Backend 2025**. O projeto consiste em um intermediador de pagamentos de alta performance, projetado para ser resiliente e maximizar o lucro, mesmo sob condições de instabilidade dos serviços externos.

O principal objetivo foi construir uma API que escolhesse de forma inteligente entre dois processadores de pagamento (um padrão, mais barato, e um de fallback, mais caro), garantindo a consistência dos dados e mantendo uma latência extremamente baixa (p99).

## Especificação técnica

Para resolver o desafio, optei pela seguinte stack, visando um equilíbrio entre performance, resiliência e simplicidade de implementação dentro das restrições de recursos (1,5 CPU e 350MB de RAM).

- **Linguagem/Framework:** `[C# com .NET 8]`
- **Banco(s) de Dados:** `[PostgreSQL]`
- **Load Balancer:** `[YARP]`

## Estratégia e Lógica de Negócio

- .NET Core
- PostgreSQL
- Nginx
- Docker
- Docker Compose
