Neste projeto apliquei o **multithreading** com o `worker_threads` para o processamento de pagamentos, aliviando o gargalo de tantas tarefas concorrentes — que foram enfileradas bonitinhas graças ao [`p-queue`](https://www.npmjs.com/package/p-queue).

Apesar d'eu querer seguir a filosofia do Node.js e demonstrar o potencial singlethread, seu desempenho (neste desafio) é bastante inferior aos concorrentes, que foram projetados para serem ultrarápidos.

No armazenamento, foi utilizado o **Redis**. Optei por ele pela sua simplicidade e suporte ao padrão de **pub/sub na mensageria**, me permitindo orquestrar as pausas e retomadas das tasks — que, para ser sincero, não era necessário, mas eu quis validar alguns tópicos de paralelismo.

Desenvolvi o protótipo com [**express**](https://expressjs.com/), depois fui pro [**koa**](https://koajs.com/) para usar somente o essencial e acabei no [módulo HTTP nativo do Node.js](https://nodejs.org/api/http.html) para ter mais liberdade sob o parsing e envio de dados.