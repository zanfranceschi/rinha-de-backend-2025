# rinha de backend

## stack

- golang, redis, nginx
- usei hexagonal arch para organizar o código

## estratégia

- colocar payments numa fila ao receber a request, um worker fica consumingo dessa fila, tentando processar o payment nos processors, não me preocupo com healthcheck, apenas coloco de volta na fila com backoff exponencial ao ter falha nos dois.
- uso o redis para a fila mencionada, e também para o summary dos payments
