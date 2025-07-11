*Esse guia foi gentilmente elaborado por [leonardosegfault](https://github.com/leonardosegfault). Link do guia original [aqui](https://github.com/zanfranceschi/rinha-de-backend-2025/issues/11).*

# Mini Guia de Setup

Assim como eu, acredito que haja muitas pessoas que tiveram ou terão dúvidas de realizar a configuração inicial, então decidi escrever esse minúsculo guia temporário para que você também não tenha que ficar caçando no repositório, como eu fiz.

O objetivo é ser bastante breve, então eu intencionalmente omiti alguns detalhes pois a própria documentação dos projetos já instruem adequadamente. Se tiver problemas ou soluções específicas, abra uma Issue que o pessoal te ajuda.

A IA também pode ser sua amiga, então elabore um texto bonitinho para que ela compreenda seu problema e consiga chegar numa solução — apesar de eu recomendar que faça sozinho para exercitar o cérebro.

### 1. Docker

Docker será utilizado do início ao final do projeto para que haja um ambiente consistente e isolado. Assim tudo poderá ser configurado e rodado com poucos comandos.

[Depois de instalado](https://docs.docker.com/get-started/get-docker/) vá até a pasta `payment-processor` e rode `docker compose up` para inicializar os servidores do payment processor.

Se tudo ocorrer como esperado, o servidor default (http://127.0.0.1:8001/) e de fallback (http://127.0.0.1:8002/) estarão online e com [seus endpoints](https://github.com/zanfranceschi/rinha-de-backend-2025/tree/main#resumo-dos-endpoints) funcionando bonitinho.

### 2. K6

Essa ferramenta [será utilizada para testar requisições na sua API local](https://github.com/zanfranceschi/rinha-de-backend-2025/tree/main/rinha-test). Assim, você poderá validar se seu backend está processando as informações direitinho e tankando o estresse.

Siga as [instruções para instalar no seu sistema operacional](https://grafana.com/docs/k6/latest/set-up/install-k6/) e depois vá para a pasta `rinha-test` para rodar o teste com `k6 run rinha.js` — mas não agora, tem algumas coisas que ainda serão resolvidas logo abaixo.

### 3. Crie rotas necessárias para rodar o teste

Além dos [endpoints a serem desenvolvidos](https://github.com/zanfranceschi/rinha-de-backend-2025/tree/main#resumo-dos-endpoints), há também um *endpoint secreto* necessário para o script não crashar, que é o `POST /purge-payments`. Ele é chamado pelo script de teste e serve para notificar uma limpeza no seu serviço.

[Seu backend também deve estar exposto na porta `9999`.](https://github.com/zanfranceschi/rinha-de-backend-2025?tab=readme-ov-file#arquitetura)

Se por algum motivo você quiser testar apenas um cenário, comente os demais no arquivo [`rinha.js`](https://github.com/zanfranceschi/rinha-de-backend-2025/blob/2ac3f62f225afd6748e9164be3c4d4ebe5d3474e/rinha-test/rinha.js#L35-L128).

### 4. Divirta-se

Desenvolva sua aplicação baseada nas especificações e realize os testes para checar se está tudo nos conformes.

Você também pode assistir [sua API apanhando ao vivo através do dashboard](https://github.com/zanfranceschi/rinha-de-backend-2025/tree/main/rinha-test#acompanhando-os-testes-via-dashboard-e-report), se quiser:

![img](https://github.com/user-attachments/assets/3be1b160-c2a0-4ab8-bab5-117e9dfe5ec9)

*(demo da minha API capenga)*

Não se esqueça de fechar a página ou clicar no **Report** para que o teste finalize e exiba os stats no terminal.

Boa sorte!