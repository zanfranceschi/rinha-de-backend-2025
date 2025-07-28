# Projeto
Projeto construido utilizando GO com framework Echo (APIs), e postgres, nginx como LB

# Arquitetura
````aiignore
[HTTP Request]
     ↓
[Controller Handler]
     ↓
[Canal/Fila Interna]
     ↓
[Worker Pool Assíncrono]
     ↓
[Processamento]
````
