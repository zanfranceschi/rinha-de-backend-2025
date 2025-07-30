# Rinha de Backend 2025 - Payment Gateway (FrankenPHP)

![Imagem gerada por IA](./assets/meme.png)

Este projeto é uma implementação para a **Rinha de Backend 2025**, um desafio que visa testar a capacidade de desenvolver um backend eficiente para intermediação de pagamentos.

## 🎯 Sobre a Rinha de Backend

A Rinha de Backend é uma competição que desafia desenvolvedores a criar backends performáticos sob restrições específicas de recursos (CPU e memória). O objetivo da edição 2025 é desenvolver um gateway de pagamentos que:

- Intermedie solicitações de pagamento para processadores externos
- Gerencie fallback entre múltiplos processadores
- Maximize o lucro escolhendo o processador com menor taxa
- Mantenha alta performance e disponibilidade
- Forneça relatórios de auditoria para o "Banco Central"

## 🏗️ Arquitetura Simples

Este projeto foi desenvolvido com uma **arquitetura minimalista** para fins de desenvolvimento rápido e prototipagem. A aplicação está concentrada em apenas **três arquivos PHP**:

### Componentes Principais

1. **API Gateway** (`cmd/api.php`) - Servidor web com 40 workers FrankenPHP por instância
2. **Payment Worker** (`cmd/payment-worker.php`) - Processador assíncrono de pagamentos
3. **Health Worker** (`cmd/health-worker.php`) - Monitor de saúde dos processadores
4. **Redis** - Cache e fila de jobs
5. **Nginx** - Load balancer para distribuir requisições

### Arquitetura Física

```
Cliente -> Nginx (Load Balancer) -> API Instances (api01, api02)
                                         |
                                         v
                                     Redis Queue
                                         |
                                         v
                              Payment Worker Process
                                         |
                                         v
                              Payment Processors (Default/Fallback)
                                         ^
                                         |
                              Health Worker (Monitor)
```

### Endpoints Disponíveis

- `POST /payments` - Recebe solicitações de pagamento
- `GET /payments-summary` - Retorna resumo de pagamentos por período
- `POST /purge-payments` - Limpa todos os dados (desenvolvimento)

## 🚀 Como Rodar o Projeto

### Pré-requisitos

- Docker
- Docker Compose
- Acesso aos Payment Processors externos

### Configuração do Ambiente

1. **Clone o repositório:**

```bash
git clone <seu-repositorio>
cd rinha-2025/franken
```

2. **Inicie o Payment Processor (necessário):**

```bash
# Em outro terminal, navegue até o diretório do payment processor
cd ../rinha-de-backend-2025-payment-processor
docker-compose up -d
```

3. **Inicie a aplicação:**

```bash
docker-compose up -d
```

### Verificação

A aplicação estará disponível em `http://localhost:9999`

**Teste de conectividade:**

```bash
# Teste o endpoint de health
curl http://localhost:9999/payments-summary

# Envie um pagamento de teste
curl -X POST http://localhost:9999/payments \
  -H "Content-Type: application/json" \
  -d '{"correlationId": "test-001", "amount": 100.50}'
```

### Monitoramento

**Logs dos serviços:**

```bash
# Logs da API
docker-compose logs -f api01 api02

# Logs do Payment Worker
docker-compose logs -f payment-worker

# Logs do Health Worker
docker-compose logs -f health-worker

# Logs do Redis
docker-compose logs -f redis
```

## 🔧 Tecnologias Utilizadas

- **FrankenPHP** - Runtime PHP de alta performance
- **PHP 8.4** - Linguagem principal
- **Redis** - Cache e sistema de filas
- **Nginx Alpine** - Load balancer otimizado e proxy reverso
- **Docker** - Containerização

## 📊 Recursos e Limitações

Conforme as regras da Rinha de Backend 2025:

- **CPU Total:** 1.5 cores
- **Memória Total:** 350MB
- **Porta de Exposição:** 9999

### Distribuição de Recursos

- **API (2 instâncias):** 0.245 CPU / 110MB cada
- **Payment Worker:** 0.6 CPU / 15MB
- **Health Worker:** 0.01 CPU / 10MB
- **Nginx:** 0.12 CPU / 50MB
- **Redis:** 0.28 CPU / 55MB

## 🎲 Estratégia de Negócio

O sistema implementa uma arquitetura com workers especializados:

### Health Worker

- **Monitoramento Contínuo:** Verifica health-check dos processadores a cada 5 segundos
- **Cache Inteligente:** Armazena status no Redis para acesso rápido
- **Detecção de Falhas:** Monitora disponibilidade e tempo de resposta

### Payment Worker

1. **Múltiplos Processos:** Gerenciador que mantém 5 workers concorrentes para alta throughput
2. **Verificação de Saúde:** Consulta cache de status atualizado pelo Health Worker
3. **Seleção Inteligente:**
   - Usa processador padrão se estável
   - Alterna para fallback se padrão estiver falhando
   - Considera tempo de resposta na decisão (máximo 2x mais lento)
4. **Timeouts Otimizados:** Conexão em 1s, timeout total de 3s
5. **Tratamento de Erros:** Detecta e trata códigos HTTP 422 (dados inválidos)
6. **Prevenção de Duplicatas:** Evita reprocessamento usando correlationId
7. **Auto-restart:** Workers reiniciam automaticamente em caso de falha

## 📈 Performance

- **Processamento Assíncrono:** Desacopla recebimento de processamento
- **Cache Inteligente:** Health-check cacheado para reduzir overhead
- **Múltiplas Instâncias:** Load balancing entre APIs com 40 workers FrankenPHP cada
- **Workers Concorrentes:** 5 processos paralelos para pagamentos
- **Workers Dedicados:** Processamento otimizado em background
- **Scripts Lua:** Otimização Redis com script Lua para summaries
- **Conexões Persistentes:** Reutilização de conexões curl e Redis
- **Memoria Otimizada:** Payment worker usa apenas 15MB para 5 processos
- **Alta Concorrência:** Total de 80 workers na camada API (40 por instância)
- **Timeouts Agressivos:** Conexões em 1s, timeout total de 3s para máxima responsividade
- **Decisão Inteligente:** Processador escolhido com base em falhas e tempo de resposta (2x threshold)

## 🔍 Desenvolvimento e Debug

**Limpar todos os dados:**

```bash
curl -X POST http://localhost:9999/purge-payments
```

**Monitorar fila Redis:**

```bash
docker-compose exec redis redis-cli
> LLEN payment_jobs
> LRANGE payment_jobs 0 -1
```

## ⚠️ Limitações da Arquitetura Simples

Esta implementação foi criada para **fins de desenvolvimento e prototipagem** com as seguintes limitações:

- **Código Monolítico:** Lógica concentrada em poucos arquivos
- **Sem Framework:** Implementação raw em PHP para máxima performance
- **Configuração Hardcoded:** URLs e configurações fixas no código
- **Logging Básico:** Sistema de logs simplificado
- **Sem Testes:** Focado em desenvolvimento rápido

Para um ambiente de produção, seria recomendável:

- Separar responsabilidades em módulos
- Implementar logging estruturado
- Adicionar testes automatizados
- Configurações externalizadas
- Tratamento de erros mais robusto

---

**Nota:** Este projeto faz parte da Rinha de Backend 2025 e foi desenvolvido com foco em performance e simplicidade dentro das restrições estabelecidas pela competição.
