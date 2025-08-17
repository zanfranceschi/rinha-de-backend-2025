# Gabriel Rinha Backend

Backend do sistema *Rinha* com microserviços e workers para processamento de pagamentos.
Go ainda é novidade pra mim, decidi começar a estudar a linguagem em junho de 2025, usei a rinha como oportunidade para praticar com a linguagem. 

## Stack

- **Go** – lógica de negócios e API
- **Redis** – fila de processamento e armazenamento temporário
- **Docker / Docker Compose** – containerização de serviços
- **Nginx** – proxy reverso e balanceamento de carga

## Serviços

| Serviço      | Descrição                                                   |
|-------------|-------------------------------------------------------------|
| `app1-3`    | APIs principais que recebem e processam pagamentos         |
| `worker1-3` | Workers que consomem filas do Redis e processam pagamentos em background |
| `redis`     | Fila de mensagens e armazenamento temporário               |
| `nginx`     | Proxy reverso e roteamento de tráfego                      |

## Como rodar localmente

1. Clone o repositório:
```bash
git clone https://github.com/lPoltergeist/rinha-backend/tree/assincrono

cd rinha-backend
```

2.Suba os containers com Docker Compose:

```bash
docker-compose up -d
```


## Minha solução

### Arquitetura e Fluxo de Processamento

A solução foi desenhada para garantir escalabilidade, confiabilidade e consistência no processamento de pagamentos.

### 1. Entrada de requisições
- O **Nginx** atua como **load balancer**, utilizando **round robin** para distribuir requisições entre as três instâncias de **API producers** (`app1`, `app2`, `app3`).

### 2. Fila de processamento
- Cada producer insere as requisições recebidas em uma **fila Redis**, garantindo desacoplamento entre recepção e processamento.
- Essa abordagem permite que a API continue respondendo rapidamente sem esperar pelo processamento completo.

### 3. Workers e consumo
- Existem três instâncias de **workers/consumers** (`worker1`, `worker2`, `worker3`) que consomem a fila.
- Cada worker segue o **Worker Pool Pattern**, processando mensagens em paralelo e distribuindo a carga entre suas threads.
- Essa estrutura garante que os pagamentos sejam processados de forma eficiente e consistente, mesmo sob alta demanda.

![Worker Pool Pattern](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fnnhrwfv6nwd30xcxzov5.png)

### 4. Envio para Payment Processor
- Os workers processam os dados da fila e realizam o envio para o **payment-processor**, mantendo o controle de falhas e retries conforme necessário.

### 5. Benefícios da arquitetura
- **Escalabilidade horizontal:** podemos adicionar mais producers ou workers conforme a demanda.