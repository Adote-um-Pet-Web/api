# API - Adote um Pet Web - Plataforma de Adoção de Animais

Este é um projeto Open Source da API de uma plataforma de adoção de animais.

O frontend pode ser encontrado em: [Web - Adote um Pet Web](https://github.com/Adote-um-Pet-Web/web)

A plataforma foi projetada para facilitar o processo de adoção de animais, onde os usuários possam encontrar seu futuro pet de estimação de maneira simples e rápida, com todas as informações necessárias para realizar uma adoção consciente e responsável. 

**Importante:** Este projeto está em andamento. 

## Stack
- Ruby on Rails
- PostgreSQL
- Autenticação com Devise
- Autorização com Pundit
- Hospedagem AWS

## Como usar?
O sistema possui endpoints específicos para diferentes tipos de usuários com permissões variadas.

Existem perfis distintos na aplicação: administrador, usuário doador e usuário adotante.

- O **usuário doador** é responsável por cadastrar, atualizar e remover animais para adoção.
- O **usuário adotante** tem permissão para visualizar animais disponíveis e iniciar o processo de adoção.

Também existem rotas não autenticadas, como a listagem de animais disponíveis para adoção. Para o usuário adotante visualizar as informações de contato do doador do animal, é necessário está cadastrado na plataforma.

## Configuração da Aplicação
Para configurar o projeto, você precisa ter:

- PostgreSQL instalado.
- Ruby >= 3.2.0 (mínimo requerido para o Rails 7).

Não esqueça de configurar corretamente o seu `database.yml`.

Para instalar as dependências, use o comando:
  ```
  bundle install
  ```

### Configurando o Ambiente de Desenvolvimento

- Criar bancos de dados:
  ```
  rails db:create
  ```
- Rodar migrações:
  ```
  rails db:migrate
  ```
- Iniciar o servidor:
  ```
  rails s
  ```

Para rodar testes:
```
  rspec
  ```

## Como usar a API?
- A documentação da API pode ser encontrada na pasta `doc`, incluindo arquivos para importação no Postman.

## Escopos da API
Existem escopos principais na API:

- `v1/auth`: para autenticação
- `v1/pets`: cadastrar pets disponíveis para adoção
- `v1/adoptions`: para usuários adotantes realizar o processo de adoção.

Cada escopo possui sua própria versão, por exemplo, `v1/pets`.

## Autenticação
A autenticação é realizada através do Devise. As requisições autenticadas precisam incluir cabeçalhos de autenticação, que são atualizados a cada requisição.


