# Rinha de Backend 2025 - @steixeira93

## Stack

- **Linguagem**: Go 1.22
- **Web Framework**: Fiber (baseado em FastHTTP)
- **Cache**: In-memory com Ristretto + persistência opcional em Redis
- **Mensageria**: RPC customizado com goroutines e channels
- **Load Balancer**: Nginx
- **Arquitetura**: Microserviços com separação de responsabilidades

## Tecnologias Utilizadas

### Core
- Go 1.22
- Fiber v2 (Web Framework)
- FastHTTP (HTTP Server de alta performance)

### Bibliotecas
- `dgraph-io/ristretto` - Cache in-memory de alta performance
- `shopspring/decimal` - Precisão decimal para valores monetários
- `sony/gobreaker` - Circuit breaker para resiliência
- `panjf2000/ants` - Pool de goroutines
- `goccy/go-json` - JSON encoder/decoder otimizado

### Arquitetura
- 3 microserviços: API (2 instâncias), Cache Service, Consumer
- Comunicação via RPC customizado sobre TCP
- Queue in-memory com persistência opcional
- Circuit breaker para fallback de processadores
- Pool de workers para processamento concorrente

## Como executar

```bash
# Iniciar todos os serviços
./start.sh

# Parar todos os serviços
./stop.sh

# Testar
curl -X POST http://localhost:9999/payments \
  -H 'Content-Type: application/json' \
  -d '{"correlationId": "123e4567-e89b-12d3-a456-426614174000", "amount": 100.50}'
```

## Repositório

Código fonte: https://github.com/steixeira93/rinha-solucao-go

## Limites de Recursos

- **API (2x)**: 0.2 CPU, 50MB RAM cada
- **Consumer**: 0.4 CPU, 80MB RAM
- **Cache**: 0.3 CPU, 100MB RAM
- **Nginx**: 0.4 CPU, 70MB RAM
- **Total**: 1.5 CPU, 350MB RAM (dentro dos limites)
