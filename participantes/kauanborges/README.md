# Serviço Proxy de Pagamento

Esta é uma aplicação Spring Boot implementada em Java, compilada para código nativo para atender às restrições da competição. Atua como um serviço proxy de pagamento com balanceamento de carga e processamento em memória.

## Tecnologias Utilizadas

* **Java 21** com Spring Boot (Netty para programação reativa)
* **Plugin GraalVM** para compilação nativa
* **Nginx** para balanceamento de carga das requisições de pagamento recebidas
* Estruturas de dados em memória para enfileiramento e armazenamento

## Visão Geral da Arquitetura

1. **Fluxo de Requisição:**
   Requisições de pagamento chegam no endpoint `/payments`.
   O Nginx distribui as requisições recebidas entre múltiplas instâncias deste serviço (microserviços).

2. **Enfileiramento em Memória:**
   As requisições são enfileiradas em memória até que uma thread de processamento as consuma.

3. **Processamento:**
   A thread de processamento envia os dados do pagamento para o processador externo. Este serviço atua como proxy e não processa os pagamentos diretamente.

4. **Armazenamento:**
   Após o processamento bem-sucedido do pagamento, os resultados são salvos na estrutura de dados em memória para posterior consulta e resumo.

5. **Endpoint de Resumo:**
   Agrega dados de duas instâncias do microserviço, fornecendo uma visão consolidada dos dados de pagamento.

## Repositório

Você pode encontrar o código-fonte no repositório:
[https://github.com/borgeskauan/payment-processor-proxy](https://github.com/borgeskauan/payment-processor-proxy)