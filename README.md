# To Do List - V360

Aplicação full-stack desenvolvida em Ruby on Rails como parte do desafio técnico da V360.  
Cada usuário possui suas próprias listas, com autenticação via Devise e validação de senha robusta.

---

## Tecnologias utilizadas

- Ruby on Rails 8.1
- SQLite (desenvolvimento) / PostgreSQL (produção)
- Tailwind CSS 4 (estilização)
- Hotwire (Turbo + Stimulus) – atualizações dinâmicas
- SortableJS – arrastar e soltar listas e itens
- Devise – autenticação de usuários
- GitHub Projects e Issues – organização e fluxo de trabalho

---

## Funcionalidades

- **Autenticação de usuários**: registro, login, logout (Devise)
- **Senhas seguras**: mínimo 8 caracteres, contendo pelo menos uma letra maiúscula e um caractere especial
- **Kanban visual**: listas organizadas em colunas estilo Trello
- **Criação e gerenciamento de listas** com título e descrição
- **Adição, exclusão e conclusão de itens** dentro das listas
- **Drag-and-drop** para reordenar listas e itens (incluindo movimentação entre listas)
- **Atualizações em tempo real** com Turbo Streams (criação, edição, exclusão e conclusão de itens sem recarregar a página)
- **Mensagens flash** que desaparecem automaticamente após 3 segundos
- **Design responsivo** com cores personalizadas
- **API RESTful** com suporte a JSON (listas e itens) – todas as rotas exigem autenticação

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
   git clone https://github.com/RichardPiccoli/to_do_list
   cd to_do_list
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
   *A primeira página exibida será a de login. Registre um novo usuário ou faça login com credenciais existentes.*

---

## Estrutura de dados

**User** (usuário) – gerenciado pelo Devise  
- `id` (integer)  
- `email` (string, único)  
- `encrypted_password` (string)  
- `created_at`, `updated_at`

**List** (lista) – pertence a um `user`  
- `id` (integer)  
- `title` (string, obrigatório, entre 3 e 100 caracteres)  
- `description` (text, opcional, até 500 caracteres)  
- `position` (integer, usado para ordenação)  
- `user_id` (integer, chave estrangeira)  
- `created_at`, `updated_at`

**Item** (tarefa) – pertence a uma `list`  
- `id` (integer)  
- `title` (string, obrigatório, entre 3 e 100 caracteres)  
- `notes` (text, opcional, até 300 caracteres)  
- `done` (boolean, padrão false)  
- `due_date` (datetime, opcional)  
- `position` (integer, para ordenação)  
- `list_id` (integer, chave estrangeira)  
- `created_at`, `updated_at`

Relacionamentos:  
- Usuário tem muitas listas (`has_many :lists`)  
- Lista tem muitos itens (`has_many :items`)  
- Item pertence a uma lista (`belongs_to :list`)

---

## API (exemplos de requisições)

Todas as rotas da API exigem que o usuário esteja autenticado. O cookie de sessão é enviado automaticamente após o login.

### Listar todas as listas do usuário
```
GET /lists
```

### Criar uma nova lista
```
POST /lists
Content-Type: application/json

{
  "list": {
    "title": "Estudos",
    "description": "Tarefas da semana"
  }
}
```

### Obter uma lista com seus itens
```
GET /lists/1
```

### Criar um item em uma lista
```
POST /lists/1/items
Content-Type: application/json

{
  "item": {
    "title": "Estudar Rails"
  }
}
```

### Reordenar listas (usado internamente pelo drag-and-drop)
```
PATCH /lists/reorder
Content-Type: application/json

{
  "list_ids": [2, 1, 3]
}
```

### Reordenar itens de uma lista
```
PATCH /lists/1/items/reorder
Content-Type: application/json

{
  "item_ids": [3, 1, 2]
}
```

### Mover um item para outra lista
```
PATCH /items/1/move
Content-Type: application/json

{
  "list_id": 2,
  "position": 0
}
```

---

## Organização do desenvolvimento

- **Issues** e **Projects** no GitHub foram utilizados para planejar e acompanhar o desenvolvimento.
- **Pull Requests** com template para descrever mudanças e checklist de qualidade.
- Uso de **branches por feature** e merges via PR.
- **IA** (ChatGPT, Gemini) auxiliou na geração de código, estruturação de arquivos e revisão de boas práticas. Todo o código foi revisado manualmente.

---

## Deploy

A aplicação está configurada para deploy no Render (Plano Gratuito) com PostgreSQL.  
O arquivo `render.yaml` descreve o serviço web e o banco de dados.  
Variáveis de ambiente necessárias:
- `RAILS_MASTER_KEY`: conteúdo do arquivo `config/master.key`
- `SECRET_KEY_BASE`: gerada automaticamente pelo Render
- `DATABASE_URL`: fornecida automaticamente pelo banco PostgreSQL

Após o deploy, a aplicação estará disponível em `https://to-do-list-tlyn.onrender.com`.

---

## Autor

Desenvolvido por Richard Piccoli.
