#!/bin/bash

# Script para testar localmente a submissão da Rinha

PARTICIPANT="steixeira93"
MAX_REQUESTS=550

echo "=== Teste Local da Rinha de Backend 2025 ==="
echo "Participante: $PARTICIPANT"
echo ""

# Parar containers se existirem
echo "Parando containers existentes..."
cd participantes/$PARTICIPANT
docker compose down -v --remove-orphans 2>/dev/null
cd ../..

# Iniciar processadores de pagamento
echo "Iniciando processadores de pagamento..."
cd participantes/$PARTICIPANT
docker compose -f docker-compose.processors.yml up -d

# Aguardar processadores
echo "Aguardando processadores..."
sleep 10

# Iniciar aplicação
echo "Iniciando aplicação..."
docker compose up -d --build

# Aguardar aplicação estar pronta
echo "Aguardando aplicação estar pronta..."
max_attempts=15
attempt=1
success=1

while [ $success -ne 0 ] && [ $max_attempts -ge $attempt ]; do
    curl -f -s http://localhost:9999/payments-summary
    success=$?
    echo "Tentativa $attempt de $max_attempts..."
    sleep 5
    ((attempt++))
done

if [ $success -eq 0 ]; then
    echo ""
    echo "=== Aplicação está pronta! Iniciando testes k6 ==="
    echo ""
    
    # Executar testes k6
    cd ../../rinha-test
    k6 run -e MAX_REQUESTS=$MAX_REQUESTS -e PARTICIPANT=$PARTICIPANT -e TOKEN=$(uuidgen) rinha.js
    
    # Parar containers
    echo ""
    echo "Parando containers..."
    cd ../participantes/$PARTICIPANT
    docker compose down -v
    docker compose -f docker-compose.processors.yml down -v
    
    echo ""
    echo "=== Teste concluído! ==="
else
    echo ""
    echo "ERRO: Aplicação não respondeu após $max_attempts tentativas"
    echo "Verifique os logs com: docker compose logs"
    
    # Parar containers mesmo com erro
    cd participantes/$PARTICIPANT
    docker compose down -v
    docker compose -f docker-compose.processors.yml down -v
    exit 1
fi
