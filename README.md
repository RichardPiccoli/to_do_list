# To Do List - V360

Aplicação full-stack desenvolvida em Ruby on Rails como parte do desafio técnico da V360.

---

## Tecnologias utilizadas

- Ruby on Rails 8.1
- SQLite (desenvolvimento) / PostgreSQL (produção)
- Tailwind CSS 4 (estilização)
- Hotwire (Turbo + Stimulus) – para atualizações dinâmicas
- SortableJS – para arrastar e soltar listas e itens
- GitHub Projects e Issues – para organização e fluxo de trabalho

---

## Funcionalidades

- **Kanban visual**: listas de tarefas organizadas em colunas estilo Trello.
- **Criação e gerenciamento de listas** com título e descrição.
- **Adição, edição, exclusão e conclusão de itens** dentro das listas.
- **Drag-and-drop** para reordenar listas e itens (incluindo movimentação de itens entre listas).
- **Atualizações em tempo real** com Turbo Streams (criação, edição, exclusão e conclusão de itens sem recarregar a página).
- **Mensagens flash** que desaparecem automaticamente após 3 segundos.
- **Design responsivo** com cores personalizadas (roxo e laranja da empresa).
- **API RESTful** com suporte a JSON (listas e itens).

---

## Como rodar o projeto

### Pré-requisitos

- Ruby 3.2 ou superior (recomenda-se o uso de rbenv)
- Bundler
- Node.js (para o ambiente de desenvolvimento com Tailwind)
- Git

### Passos

1. **Clonar o repositório**
```bash
git clone https://github.com/SEU_USUARIO/todo-v360.git
```
```bash
cd todo-v360
```


2. **Instalar as dependências**
```bash
bundle install
```


3. **Configurar o banco de dados**
```bash
rails db:create db:migrate
```


4. **Iniciar o servidor de desenvolvimento (com Tailwind watcher)**
```bash
bin/dev
```

Isso iniciará o servidor Rails na porta 3000 e o watcher do Tailwind CSS.

5. **Acessar a aplicação**

Abra o navegador e visite `http://localhost:3000`.

---

## Estrutura de dados

**List (lista)**  
- `id` (integer)  
- `title` (string, obrigatório, entre 3 e 100 caracteres)  
- `description` (text, opcional, até 500 caracteres)  
- `position` (integer, usado para ordenação)  
- `created_at`, `updated_at`

**Item (tarefa)**  
- `id` (integer)  
- `title` (string, obrigatório, entre 3 e 100 caracteres)  
- `notes` (text, opcional, até 300 caracteres)  
- `done` (boolean, padrão false)  
- `due_date` (datetime, opcional)  
- `position` (integer, para ordenação)  
- `list_id` (integer, chave estrangeira)  
- `created_at`, `updated_at`

Relacionamento: uma lista tem muitos itens.

---

## API (exemplos de requisições)

### Listar todas as listas
GET /lists


### Criar uma nova lista
POST /lists
Content-Type: application/json

{
"list": {
"title": "Estudos",
"description": "Tarefas da semana"
}
}


### Obter uma lista com seus itens
GET /lists/1


### Criar um item em uma lista
POST /lists/1/items
Content-Type: application/json

{
"item": {
"title": "Estudar Rails"
}
}


### Reordenar listas (usado internamente pelo drag-and-drop)
PATCH /lists/reorder
Content-Type: application/json

{
"list_ids": [2, 1, 3]
}


### Reordenar itens de uma lista
PATCH /lists/1/items/reorder
Content-Type: application/json

{
"item_ids": [3, 1, 2]
}


### Mover um item para outra lista
PATCH /items/1/move
Content-Type: application/json

{
"list_id": 2,
"position": 0
}

---

## Organização do desenvolvimento

- **Issues** e **Projects** no GitHub foram utilizados para planejar e acompanhar o desenvolvimento.
- **Pull Requests** com template para descrever mudanças e checklist de qualidade.
- Uso de **branches por feature** e merges via PR.
- **IA** (ChatGPT, Gemini) auxiliou na geração de código, estruturação de arquivos e revisão de boas práticas. Todo o código foi revisado manualmente.

---

## Autor

Desenvolvido por Richard Piccoli para o processo seletivo da V360.