# Rinha de Backend 2025 - Solução Bourne Again Shell

## Tecnologias utilizadas:
- **ShellScript** - Tempo de inicialização, menor dependências, merreca de memória e processamento.
- **Xinetd** - Antigo e rápido pra época, servidores de alto desempenho, fácil configuração, merreca de memória, processamento variavel porém baixo.
- **SQLite** - Velocidade, baixo consumo, merreca de memória e processamento.

## Estratégia:
focando na disponibilidade do serviço pelo baixo consumo, permite garantir recebimento dos dados de maneira mais ágil.

## Breve explicação:
 O meu objetivo principal é "empurrar a bucha" para o próximo o máximo que der, sem deixar a peteca cair, e minimizar ao máximo tempo de inicialização, seja em declarações de variáveis, funções e bibliotecas. com isso, processando os dados de maneira mais cruas, em testes internos, consegui atingir a margem de 2Mil conexões processadas em ~6 segundos, usando Shell, Xinetd e 1 arquivo de configuração simples.

## maneira de rodar:
```
docker compose up
```
OBS: ainda não deve funcionar, estou montando e calculando/revendo a estrutura primeiro (baixa familiaridade com docker).

## Informação adicional não relevante:
 Ainda é necessário a construção do código inteiro em si no momento em que escrevo este README.md, estou focando em montar a estrutura completa corretamente, pela minha baixa familiaridade com docker, os códigos produzidos até o breve momento foram códigos conceituais e experimentais para projetos pessoais que realizei, os resultados foram muito bons para tecnologias negligenciadas, me fazendo rever bastante sobre opiniões muito reproduzidas no mundo DEV de maneira geral.
