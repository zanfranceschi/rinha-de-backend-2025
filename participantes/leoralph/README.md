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

Este projeto foi desenvolvido com uma **arquitetura minimalista** para fins de desenvolvimento rápido e prototipagem. A aplicação está concentrada em apenas **dois arquivos PHP**:

### Componentes Principais

1. **API Gateway** (`cmd/api.php`) - Servidor web que expõe os endpoints
2. **Worker** (`cmd/worker.php`) - Processador assíncrono de pagamentos
3. **Redis** - Cache e fila de jobs
4. **Caddy** - Load balancer para distribuir requisições

### Arquitetura Física

```
Cliente -> Caddy (Load Balancer) -> API Instances (api01, api02)
                                         |
                                         v
                                     Redis Queue
                                         |
                                         v
                                     Worker Process
                                         |
                                         v
                              Payment Processors (Default/Fallback)
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

# Logs do Worker
docker-compose logs -f worker

# Logs do Redis
docker-compose logs -f redis
```

## 🔧 Tecnologias Utilizadas

- **FrankenPHP** - Runtime PHP de alta performance
- **PHP 8.4** - Linguagem principal
- **Redis** - Cache e sistema de filas
- **Caddy** - Load balancer e proxy reverso
- **Docker** - Containerização

## 📊 Recursos e Limitações

Conforme as regras da Rinha de Backend 2025:

- **CPU Total:** 1.5 cores
- **Memória Total:** 350MB
- **Porta de Exposição:** 9999

### Distribuição de Recursos

- **API (2 instâncias):** 0.3 CPU / 90MB cada
- **Worker:** 0.6 CPU / 80MB
- **Caddy:** 0.15 CPU / 50MB
- **Redis:** 0.15 CPU / 40MB

## 🎲 Estratégia de Negócio

O worker implementa uma estratégia inteligente para escolha do processador:

1. **Verificação de Saúde:** Consulta health-check dos processadores (cache de 5s)
2. **Seleção Inteligente:**
   - Usa processador padrão se estável
   - Alterna para fallback se padrão estiver falhando
   - Considera tempo de resposta na decisão
3. **Retry Automático:** Tenta processador alternativo em caso de falha
4. **Prevenção de Duplicatas:** Evita reprocessamento usando correlationId

## 📈 Performance

- **Processamento Assíncrono:** Desacopla recebimento de processamento
- **Cache Inteligente:** Health-check cacheado para reduzir overhead
- **Múltiplas Instâncias:** Load balancing entre APIs
- **Workers Dedicados:** Processamento otimizado em background

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
