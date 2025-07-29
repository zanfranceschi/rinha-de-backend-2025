# Rinha de Backend 2025 - WendelMax

## Tecnologias Utilizadas

- **.NET 9.0** com otimizações de performance
- **ASP.NET Core** com Minimal APIs
- **PostgreSQL** com Dapper para persistência
- **Nginx** para load balancing
- **Docker & Docker Compose** para containerização
- **Channels** para processamento assíncrono
- **Circuit Breaker** para resiliência

## Arquitetura

- **Processamento Assíncrono**: Pagamentos são enfileirados em Channels e processados em background
- **Fallback Inteligente**: Alterna automaticamente entre processadores com circuit breaker
- **Health Checks**: Monitoramento contínuo da saúde dos processadores
- **Controle de Concorrência**: Ajuste dinâmico baseado na latência
- **Otimização de Memória**: Limite total de 350MB para todos os serviços

## Estratégia de Performance

- **Maximização de Lucro**: Prioriza processador default (5% taxa) sobre fallback (15% taxa)
- **Processamento Concorrente**: Até 200 pagamentos simultâneos
- **Retry Agressivo**: 5 tentativas no default antes do fallback
- **Monitoramento em Tempo Real**: Health checks a cada 5 segundos
- **Ajuste Dinâmico**: Concorrência adaptativa baseada na performance

## Limites de Recursos

- **Backend**: 1.2 CPU, 200MB RAM
- **PostgreSQL**: 0.2 CPU, 128MB RAM  
- **Nginx**: 0.1 CPU, 20MB RAM
- **Total**: 1.5 CPU, 348MB RAM

## Repositório do Código Fonte

https://github.com/wendelmax/RinhaBackend.Net 