#!/bin/bash

echo "=== Iniciando Rinha de Backend 2025 ==="

# Criar rede payment-processor se não existir
echo "Criando rede payment-processor..."
docker network create payment-processor 2>/dev/null || true

# Iniciar processadores de pagamento
echo "Iniciando processadores de pagamento..."
docker compose -f docker-compose.processors.yml up -d

# Aguardar processadores estarem prontos
echo "Aguardando processadores..."
sleep 5

# Verificar se processadores estão rodando
echo "Verificando processadores..."
curl -s http://localhost:8001/health || echo "Processador default não está respondendo"
curl -s http://localhost:8002/health || echo "Processador fallback não está respondendo"

# Iniciar aplicação principal
echo "Iniciando aplicação principal..."
docker compose up -d

# Aguardar aplicação estar pronta
echo "Aguardando aplicação..."
sleep 10

# Verificar se está tudo rodando
echo "Verificando serviços..."
docker compose ps

echo "=== Aplicação iniciada! ==="
echo "API disponível em: http://localhost:9999"
echo ""
echo "Para testar:"
echo "curl -X POST http://localhost:9999/payments -H 'Content-Type: application/json' -d '{\"correlationId\": \"123e4567-e89b-12d3-a456-426614174000\", \"amount\": 100.50}'"
