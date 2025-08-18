# Rinha de Backend 2025 - Go+gRPC Solution

## Tecnologias utilizadas

- **Linguagem:** Go
- **Comunicação:** gRPC (interno), HTTP/REST (API)
- **Balanceador:** Nginx
- **Orquestração:** Docker Compose

## Arquitetura

**2-Frontend + Backbone Pattern:**
```
[Nginx:9999] → [Frontend1:8081, Frontend2:8082] → gRPC → [Backbone:8080] → [Processors]
```

### Componentes

- **Backbone**: Servidor gRPC com processamento assíncrono de pagamentos. Mantem a fila de pagamentos a serem processados, lança as goroutines para processamento dos items da fila, e mantém em memória o registro de pagamentos já processados.
- **Frontend**: Gateway HTTP para gRPC (2 instâncias)
- **Nginx**: Load balancer entre frontends

### Recursos Alocados
- **Total**: 1.5 CPU, 350MB (dentro dos limites)
- **Backbone**: 0.8 CPU, 160MB
- **Frontend1**: 0.2 CPU, 40MB
- **Frontend2**: 0.2 CPU, 40MB
- **Nginx**: 0.3 CPU, 110MB

### Características principais:
- **Processamento assíncrono**: Respostas HTTP imediatas, pagamentos processados em background
- **Worker pool**: Pool de workers para processar pagamentos de forma concorrente
- **Health monitoring**: Monitoramento dos processadores para decisões de roteamento

## Repositório do código-fonte

[https://github.com/dbeyda/rinha-de-backend-2025](hthttps://github.com/dbeyda/rinha-de-backend-2025)