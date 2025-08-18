Submissao usando C# e .NET

### Recebendo os pagamentos

Aqui a ideia foi simples: Ao receber uma requisição de pagamento, apenas coloca ela em uma fila (redis) e retorna um 200. Cada servidor possui alguns workers que recebem os dados dessa fila e processam.

Fiz várias estratégias de processamento, mas a que mais trouxe resultado foi: usa apenas o processaor default e ignora o fallback.

### Processando estatísticas

Para processar as estatísticas eu uso o banco de dados do Redis, onde consigo recuperar todas os pagamentos bem sucedidos entre os instantes de tempo, fazer a soma e retornar no formato esperado.