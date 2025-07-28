#!/bin/bash

echo "=== Parando Rinha de Backend 2025 ==="

# Parar aplicação principal
echo "Parando aplicação principal..."
docker compose down -v

# Parar processadores
echo "Parando processadores de pagamento..."
docker compose -f docker-compose.processors.yml down -v

# Remover rede payment-processor
echo "Removendo rede payment-processor..."
docker network rm payment-processor 2>/dev/null || true

echo "=== Todos os serviços foram parados! ==="
