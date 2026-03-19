# To Do List - V360

Aplicação full-stack desenvolvida em Ruby on Rails como parte do desafio técnico da V360.

---

## Tecnologias utilizadas

- Ruby on Rails
- SQLite (desenvolvimento)
- PostgreSQL (produção - planejado)
- Hotwire (Turbo + Stimulus) *(planejado)*

---

## Funcionalidades (MVP)

- Criar listas de tarefas
- Adicionar itens em cada lista
- Marcar tarefas como concluídas

---

## Como rodar o projeto

### Pré-requisitos:
- Ruby instalado
- Rails instalado
- Git instalado

### Passos:

# Clonar repositório
```bash
git clone https://github.com/SEU_USUARIO/todo-v360.git
```

# Entrar na pasta
```bash
cd todo-v360
```

# Instalar dependências
```bash
bundle install
```

# Criar banco
```bash
rails db:create
```

# Rodar servidor
```bash
rails server
```

# Acessar em:
```bash
http://localhost:3000
```

## Modelo de Dados

List (1) para (N) Item

List:
- id
- title
- description

Item:
- id
- title
- notes
- done
- due_date
- position
- list_id