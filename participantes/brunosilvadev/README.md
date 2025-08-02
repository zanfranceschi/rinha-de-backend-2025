# Rinha de Backend 2025 - Submissão em .NET 9

Este projeto é uma submissão para a Rinha de Backend 2025, implementada em .NET 9.

O load balance foi feito com nginx
A API sobe em duas instâncias, que compartilham o mesmo redis
Nesse redis são armazenados os totais de transações para consulta
Também no redis há um cache da saúde dos payment processors

## Circuit Breaker
Esse cache da saúde segue o padrão circuit breaker, para que uma requisição que falhar ou demorar demais para responder seja imediatamente redirecionada ao processador fallback e o "breaker" seja marcado como aberto (faulty) e todas as requisições são redirecionadas ao processador fallback. Depois de 5 segundos, é feita uma checagem na saúde do processador default e se ele estiver ok, o breaker fica "semi-aberto". Se nessa condição houverem 3 requisições com sucesso, ele volta a fechar e se torna o processador padrão novamente.

## SemaphoreSlim
O cache de saúde usa a classe System.Threading.SemaphoreSlim para limitar uma única requisição por API, cujo response imediatamente é salvo no cache redis. Assim caso a outra API precise do resultado, já estará salvo. Ponto importante: as requisições enviadas ao redis que não precisam de retorno foram feitas no formato "fire and forget". O código não espera a resposta.

## DecisionService
A lógica principal está na classe DecisionService, que vai seguir a seguinte ordem de decisão: 

1. Se ambos serviços estão ok, recomenda o default processor
2. Se o default processor estiver em falha ou alta latência, checa a saúde do fallback
3. Se o fallback processor estiver okay, recomenda o fallback
4. Se o fallback estiver em falha ou alta latência também, recomenda o default processor (seguindo a lógica "fail fast")

## Misc
No Program.cs eu fiz algumas configurações para otimizar performance, como declarar os serviços em Singleton e reutilizar a mesma instância de httpClient com pool de conexões.