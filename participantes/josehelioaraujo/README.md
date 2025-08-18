# 💸 Rinha de Backend 2025 - Processador de Pagamentos

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![.NET 8.0](https://img.shields.io/badge/.NET-8.0-512BD4)
![SQLite](https://img.shields.io/badge/SQLite-003B57?logo=sqlite&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?logo=nginx&logoColor=white)
![k6](https://img.shields.io/badge/k6-7D64FF?logo=k6&logoColor=white)

Implementação para a [Rinha de Backend 2025 - Processador de Pagamentos](https://github.com/zanfranceschi/rinha-de-backend-2025) utilizando .NET 8, SQLite e conceitos modernos de alta performance.

## 📋 Sobre o Projeto

Esta implementação processa pagamentos de forma rápida e eficiente, gerenciando solicitações paralelas e garantindo consistência dos dados. A solução implementa:

- Processamento assíncrono de pagamentos
- Sistema de fallback local quando os processadores externos estão indisponíveis
- Circuit breaker para lidar com falhas em serviços externos
- Monitoramento de saúde dos componentes (health check)
- Zero falhas sob carga
- Testes de carga usando k6

## 🚀 Stack Tecnológica

### Backend
- **.NET 8**: Framework moderno de alto desempenho
- **C# 12**: Linguagem com recursos avançados para programação assíncrona
- **Minimal APIs**: Endpoints leves e eficientes

### Armazenamento
- **SQLite**: Banco de dados embarcado para persistência
- **WAL Mode**: Write-Ahead Logging para melhor concorrência

### Infraestrutura
- **Docker**: Containerização dos serviços
- **Docker Compose**: Orquestração de contêineres
- **Nginx**: Load balancer para distribuição de carga
- **Alpine Linux**: Imagens base leves

### Testes e Monitoramento
- **k6**: Ferramenta de teste de carga para verificação de performance
- **Circuit Breaker**: Monitoramento e proteção contra falhas em cascata

### Padrões e Técnicas
- **Circuit Breaker**: Proteção contra falhas em cascata
- **Backoff Exponencial**: Tentativas inteligentes em caso de falha
- **Filas em Memória**: Processamento não-bloqueante
- **Task-based Asynchronous Pattern**: Modelo assíncrono eficiente

## 🏗️ Arquitetura

```
             ┌──────────┐
             │    k6    │
             │(Test Tool)│
             └─────┬────┘
                   │
                   ▼
             ┌──────────┐
             │  Nginx   │
             │(Balance) │
             └─────┬────┘
                   │
       ┌───────────┴───────────┐
       │                       │
  ┌────▼────┐             ┌────▼────┐
  │         │             │         │
  │  API 1  │             │  API 2  │
  │         │             │         │
  └────┬────┘             └────┬────┘
       │                       │
       └───────────┬───────────┘
                   │
          ┌────────┴─────────┐
          │                  │
    ┌─────▼─────┐      ┌─────▼─────┐
    │  Default  │      │  Fallback │
    │ Processor │      │ Processor │
    └─────┬─────┘      └─────┬─────┘
          │                  │
          └───────────┬──────┘
                      │
                 ┌────▼────┐
                 │ SQLite  │
                 │ (WAL)   │
                 └─────────┘
```

## 💻 Como Executar

### Pré-requisitos
- Docker
- Docker Compose

### Passos
```bash
# Clone o repositório
git clone https://github.com/seu-usuario/rinha-backend-2025-dotnet.git

# Entre no diretório
cd rinha-backend-2025-dotnet

# Execute com Docker Compose
docker-compose up -d

# Teste a API
curl -v http://localhost:9999/health
curl -v -X POST http://localhost:9999/payments -H "Content-Type: application/json" -d '{"correlationId":"test-123","amount":100.00}'
```

## 🧪 Testes de Carga

Esta implementação foi testada com k6, a ferramenta oficial utilizada na Rinha de Backend:

### Executando os Testes
```bash
# Instalar k6 (se necessário)
# Para Ubuntu/Debian:
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
echo "deb https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
sudo apt-get update
sudo apt-get install k6

# Executar teste de carga
cd load-tests
k6 run script.js
```

### Configuração dos Testes

O script de teste de carga simula diferentes níveis de carga:
- Fase de inicialização: Aumento gradual para 500 usuários
- Fase de carga constante: Manutenção de 500 usuários simultâneos
- Fase de redução: Redução gradual para 0 usuários

Os testes avaliam:
- Tempo de resposta (com limites de P95 < 500ms)
- Taxa de erros (com limite de < 1%)
- Requisições por segundo (média de 550 req/s esperada)
- Verificação de correção das respostas

Esta configuração de teste é compatível com a definição oficial da Rinha de Backend 2025, permitindo simular cenários de alta carga para avaliar a robustez e desempenho da solução.

## 🔍 Detalhes da Implementação

### Processamento de Pagamentos
- Implementação de fallback local quando os processadores externos falham
- Uso de circuit breaker para detectar falhas nos serviços
- Sistema de filas em memória para processamento não-bloqueante

### Banco de Dados
- SQLite configurado com WAL (Write-Ahead Logging)
- Otimizações de cache e tamanho de página
- Transações eficientes

### Escalabilidade
- Múltiplas instâncias da API
- Balanceamento de carga via Nginx
- Conexões persistentes (keepalive)

### Integração com Processadores
- Comunicação via HTTP com processadores de pagamento
- Suporte a múltiplos processadores (padrão e fallback)
- Processamento local para garantir alta disponibilidade

## 📝 Planos Futuros

- Otimização adicional do tempo de resposta
- Implementação de cache distribuído
- Métricas e monitoramento em tempo real
- Migração para banco de dados com melhor suporte a concorrência

## 📜 Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE).