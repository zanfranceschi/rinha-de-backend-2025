O objetivo desse guia é ser breve, então alguns detalhes podem ter sido omitidos para fins de praticidade — a documentação de cada aplicação poderá te ajudar melhor.

Em caso de dúvidas, abra uma [Issue](https://github.com/zanfranceschi/rinha-de-backend-2025/issues) ou consulte alguma IA. Não se esqueça de explicar detalhamente seu problema para que possamos ajudar da melhor forma possível.

### Docker

Docker será utilizado do início ao final do projeto para que haja um ambiente consistente e isolado. Assim tudo poderá ser configurado e rodado com poucos comandos.

Acesse o guia [Get Docker](https://docs.docker.com/get-started/get-docker/) e instale o Docker de acordo com o seu sistema operacional.

Depois de instalado, vá até a pasta `payment-processor` e rode o comando `docker compose up` para iniciar os [servidores do payment processor](https://github.com/zanfranceschi/rinha-de-backend-2025?tab=readme-ov-file#o-desafio) necessários no processo de desenvolvimento.

Se tudo ocorrer como esperado, o servidor default (http://127.0.0.1:8001/) e de fallback (http://127.0.0.1:8002/) estarão online e com [seus endpoints](https://github.com/zanfranceschi/rinha-de-backend-2025/tree/main#resumo-dos-endpoints) funcionando.

### K6

Essa ferramenta [será utilizada para testar requisições na sua API local](https://github.com/zanfranceschi/rinha-de-backend-2025/tree/main/rinha-test). Assim, você poderá validar se seu backend está processando as informações corretamente e diagnosticar possíveis problemas.

Siga as [instruções para instalar no seu sistema operacional](https://grafana.com/docs/k6/latest/set-up/install-k6/) e, depois de implementado os [endpoints necessários](https://github.com/zanfranceschi/rinha-de-backend-2025/tree/main#resumo-dos-endpoints) no seu backend, vá até a pasta `rinha-test` para rodar o teste com `k6 run rinha.js`.

Você também pode acompanhar o teste visualmente através do dashboard do k6 definindo [algumas variáveis de ambiente](https://github.com/zanfranceschi/rinha-de-backend-2025/tree/main/rinha-test#acompanhando-os-testes-via-dashboard-e-report).

Caso queira, pode temporariamente comentar alguns cenários durante o desenvolvimento no arquivo `rinha.js`, assim desenvolvendo uma tarefa de cada vez.

#### Limpeza do Backend

Há o endpoint opcional `POST /purge-payments`. Ele pode ser implementado na sua API e será chamado no início de todo teste para que você possa realizar uma limpeza no seu backend, garantindo mais consistência nos testes locais.

> [!NOTE]  
> Não é necessário que você realize a limpeza através da API do processor pois o teste já faz essa tarefa.