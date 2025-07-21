# Rinha de Backend 2025

## Repositório

https://github.com/MXLange/rinha-backend

## Projeto

A escolha de Go foi, além de usá-lo no dia a dia, por ajudar na questão de recursos limitados.

Aproveitei ao máximo a concorrência que o Go oferece nativamente com _channels_ e _goroutines_.

No lugar de usar Redis, criei uma fila em memória usando um _channel_ que recebe os pagamentos.

Para ler e executar as tarefas, foi criado um _worker_ cuja concorrência pode ser configurada via ENV.

Paralelamente a tudo, existe um _scheduler_ que roda a cada 5 segundos para fazer verificações e decidir qual endpoint será usado na chamada principal.

## OBS

Existem pontos de melhoria, como prevenir _race conditions_ na parte do _scheduler_.  
E quem sabe algum ponto que eu não enxerguei no momento.
