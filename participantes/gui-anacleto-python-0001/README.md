# 🏆 Rinha de Backend 2025

https://github.com/GuiAnacleto/rinha-backend-2025

Este projeto é uma implementação para a Rinha de Backend 2025, um desafio de alta performance para desenvolvedores. 🚀

## 🛠️ Tecnologias Utilizadas

- **Python 3.10**: Linguagem de programação principal, utilizando o framework FastAPI para a API e Uvicorn como servidor ASGI.
- **Nginx**: Servidor web e proxy reverso para balanceamento de carga entre as instâncias da aplicação.
- **Docker e Docker Compose**: Ferramentas essenciais para a conteinerização e orquestração dos serviços, garantindo um ambiente de desenvolvimento e produção consistente.

## 📂 Estrutura do Projeto

O projeto está organizado da seguinte forma:

- `app/`: Contém o código-fonte da aplicação Python.
  - `app.py`: O coração da aplicação, onde a API FastAPI está definida.
- `nginx/`: Configurações do Nginx para o proxy reverso.
  - `nginx.conf`: Arquivo de configuração do Nginx, responsável pelo balanceamento de carga.
- `Dockerfile`: Define a imagem Docker da aplicação Python, com todas as dependências necessárias.
- `docker-compose.yml`: Arquivo de orquestração que define e executa os serviços Docker (aplicação e Nginx).
- `requirements.txt`: Lista de dependências Python do projeto, instaladas via `pip`.

## 🚀 Como Executar o Projeto

Para colocar este projeto em funcionamento, siga os passos abaixo. Certifique-se de ter o Docker e o Docker Compose instalados em sua máquina.

1.  **Clone o repositório:**

    Abra seu terminal e execute o comando para clonar o projeto:

    ```bash
    git clone https://github.com/GuiAnacleto/rinha-backend-2025.git
    cd rinha-backend-2025
    ```

2.  **Construa e inicie os serviços Docker:**

    Navegue até o diretório raiz do projeto e execute o Docker Compose:

    ```bash
    docker-compose up --build -d
    ```

    ✨ **O que este comando faz?**
    -   **Construção da Imagem**: Constrói a imagem Docker da aplicação Python com base no `Dockerfile`.
    -   **Inicialização dos Contêineres**: Inicia duas instâncias da aplicação (`app1` e `app2`) e o contêiner do Nginx.
    -   **Balanceamento de Carga**: O Nginx é configurado para balancear a carga entre as instâncias da aplicação, otimizando a performance.
    -   **Mapeamento de Portas**: Mapeia a porta `9999` do seu host para a porta `80` do contêiner Nginx, tornando a aplicação acessível.

3.  **Acesse a aplicação:**

    Após a inicialização dos serviços, a aplicação estará disponível em seu navegador ou via ferramentas como `curl`:

    ```
    http://localhost:9999
    ```

## 📞 Contato

Para mais informações, dúvidas ou sugestões, sinta-se à vontade para entrar em contato com o desenvolvedor:

[Guilherme Anacleto no LinkedIn](https://www.linkedin.com/in/ganacleto/)


