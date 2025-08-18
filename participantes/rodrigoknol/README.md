# Intermediário de Pagamentos em C

Aproveitando que queria me aprofundar em C mas não achava tempo para, resolvi focar em ir reinventando a roda onde conseguia para tentar entender bastante da linguagem, entregando o [Payment Processor (C)](https://github.com/rodrigoknol/payment-processor-c).

O objetivo foi fazer o máximo que consegui do zero, mesmo (principalmente) quando não precisava, foi um parque de diversões e espaço para ir estudando C.

O serviço tem 3 partes e cada uma é separada da próxima por uma fila:

- Web server, com o objetivo de dividir os resultados e capturar pagamentos para serem processados;
- Processador de pagamentos que tem a lógica de processamento e retry;
- DB Worker que recebe os dados dos pagamentos efetivados e guarda eles no banco.
