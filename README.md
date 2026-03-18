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

```bash
# Clonar repositório
git clone https://github.com/SEU_USUARIO/todo-v360.git

# Entrar na pasta
cd todo-v360

# Instalar dependências
bundle install

# Criar banco
rails db:create

# Rodar servidor
rails server

# Acessar em:
http://localhost:3000
```