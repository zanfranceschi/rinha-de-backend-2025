# Rinha de Backend 2025 - jairoandre/rb2025-v3

## Descrição

Solução desenvolvida em Golang para o desafio Rinha de Backend 2025. Link do repositório [aqui](https://github.com/jairoandre/rb2025-v3)

## Detalhes da Arquitetura

- nginx (load balancer)
- backend em golang
- serviço a parte de health check em golang
- dados são armazenados em memória em um sync.Map
- na consolidação um backend chama o outro
- as requisições de pagamento são processados de maneira assíncrona, através de uma fila (channel) interna para cada instância
- um mecanismo de backpressure foi implementado para evitar sobrecarga do sistema e impacto do tempo de resposta dos endpoints

## Variáveis da imagem do backend

- DEFAULT_URL: URL do payment processor default
- FALLBACK_URL: URL do payment processor fallback
- HEALTH_URL: URL do serviço health
- OTHER_URL: URL do "outro" backend (backend1 precisa saber a URL do backend2, e vice e versa)
- NUM_WORKERS: Quantidade workers (default: 550)
- JOB_BUFFER_SIZE: Tamanho do buffer de jobs (default: 20000)
- SEMAPHORE_SIZE: Limite de backpressure (default: 50)
- WORKER_SLEEP: Tempo de sleep após conclusão do processamento de um evento (default: 50)