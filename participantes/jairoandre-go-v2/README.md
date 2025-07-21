# Rinha de Backend 2025 - jairoandre/rb2025-2

## Descrição

Segunda versão de solução desenvolvida em Golang para o desafio Rinha de Backend 2025. Link do repositório [aqui](https://github.com/jairoandre/rb2025-v2).

Serviço health que roda a cada 5 segundos para verificar disponibilidade dos payments processor. Esse serviço é acessado pelos 2 backends para monitorar os sevice health. Link do repositório [aqui](https://github.com/jairoandre/rb2025-health).

## Arquitetura

A aplicação utiliza a biblioteca padrão Golang **fasthpp** para servidor web.

O armazenamento é realizado na memória da própria instância. O request de sumário dos pagamentos agrega os valores dos armazenamentos dos containers ativos.

Os eventos de pagamento só são gravados na base de dados após a confirmação dos processadores externos.

## Componentes da Solução

- nginx (load balancer)
- backend em golang

