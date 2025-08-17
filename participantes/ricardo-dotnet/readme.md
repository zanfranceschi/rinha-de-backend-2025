# API e backend para Rinha 2025

Backend para processamento de pagamentos projetado com o objetivo de desacoplar a chamada do endpoint principal do backend (http://localhost:9999) das chamadas aos serviços "payment-processor", que de fato fazem o pagamento das transações na conta dos clientes.

A arquitetura do projeto basicamente consiste em duas apis que  recebem as requisições e incluem em uma fila em memória no REDIS. Esta fila é consumida por um worker service que encaminha  para os serviços "payment-processor", considerando a disponibilidade e custos deles. 

#### **Observação importante:** Como a inclusão das mensagens na fila e o processamento vai ser assíncrono, não há de fato garantia 100% que os pagamentos serem feitos, apesar da api retornar status OK (200). Logo, o canal (frontend) que for chamar a API deve avisar que a solicitação de pagamento foi feita e que o retorno da efetivação de fato do pagamento vai ser feita de forma assíncrona usando, por exemplo, API ou tópico Kafka (escopo que está fora dos requisitos deste projeto).


## 📦 Repositórios Github - Código Fonte

* [API](https://github.com/RNAKATAN/Rinha2025_Api)
* [Worker](https://github.com/RNAKATAN/Rinha2025_Worker)

## 🛠️ Construído com


* .NET - C# 9.0, Minimal API, AOT - Linguagem C#;
* [Nginx](https://nginx.org/) - Proxy reverso e balanceamento de carga entre as 2 apis
* [Redis](https://redis.io/lp/get-started2/?utm_campaign=gg_s_core_amer_en_brand_acq_21168833255&utm_source=google&utm_medium=cpc&utm_content=redis_exact&utm_term=&device=c&matchtype=e&gad_source=1&gad_campaignid=21168833255&gbraid=0AAAAADg3Ge9YWoZwIxHCO3AH5aWHr-r7n&gclid=CjwKCAjwtfvEBhAmEiwA-DsKjlQwRgQawyyqGyeAZfS71l727xW7sx_hDj5nKWVjd8kNpmV6PsEqVBoCHIsQAvD_BwE) - Desacoplar as apis de entrada da chamada das apis payment processor atraves da criação de uma fila em memória;
* Docker/Docker-compose;

## ✒️ Autores



* **Ricardo Nakatani** 


