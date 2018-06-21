# Curriculum Management API v1.0

API simples para Cadastro e Listagem de Currículos.

## Environment

Ruby 2.5.1  
Rails 5.2.0  
Base de Dados PostgreSQL

## Instalação e Configuração

### Instalando as Gems:  

```
bundle install
```

### Criando a Base de Dados

Configurar em `config/database.yml` usuário e senha local da base de dados.

```
rails db:create
```
```
rails db:migrate
```

### Importando o JSON de Dados Inicial

```
rails curriculums:import
```

## Rodando o Projeto

```
rails server
```

## Documentação

| HTTP | Rota | Descrição |
| ----------- | ---- | --------- |
| **POST** | /curriculums | Cadastro de currículo. |
| **GET** | /curriculums | Listagem de currículos ativos ordenados por score. Recebe como parâmetros a página (page) e a quantidade de entradas (per_page). |
