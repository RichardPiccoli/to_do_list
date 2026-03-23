# CLAUDE.md

## Visão Geral do Projeto

Este é um aplicativo de lista de tarefas estilo Kanban, desenvolvido como parte do desafio técnico da V360. O projeto utiliza Ruby on Rails no back‑end e integra tecnologias modernas para uma interface dinâmica e responsiva.

O objetivo principal é permitir a criação de múltiplas listas, cada uma contendo itens que podem ser adicionados, editados, marcados como concluídos e reorganizados por arrastar e soltar. A aplicação também oferece uma API JSON para integração com outros serviços.

---

## Tecnologias Utilizadas

| Camada | Tecnologia | Versão | Finalidade |
|--------|------------|--------|------------|
| **Linguagem** | Ruby | 3.2+ | Linguagem base do Rails |
| **Framework** | Ruby on Rails | 8.1.2 | Desenvolvimento web full‑stack |
| **Banco de dados** | SQLite | (desenvolvimento) | Armazenamento local |
| | PostgreSQL | (produção) | Banco para o deploy no Render |
| **Front‑end CSS** | Tailwind CSS | 4.2.1 | Estilização utilitária |
| **Interatividade** | Hotwire (Turbo + Stimulus) | - | Atualizações dinâmicas sem JavaScript complexo |
| **Drag-and-drop** | SortableJS | - | Reordenação de listas e itens |
| **Controle de versão** | Git | - | Versionamento |
| **Hospedagem** | Render | - | Deploy com PostgreSQL gratuito |

---

## Arquitetura do Projeto

### Back‑end (Rails)

- **Modelos**:
  - `List`: representa uma lista de tarefas. Possui `title`, `description`, `position` (para ordenação) e associação `has_many :items`.
  - `Item`: representa uma tarefa. Possui `title`, `notes`, `done`, `due_date`, `position` e `belongs_to :list`.

- **Controladores**:
  - `ListsController`: gerencia as listas (CRUD, reordenação).
  - `ItemsController`: gerencia os itens (CRUD, reordenação, movimentação entre listas).

- **Rotas** (config/routes.rb):
  - Rotas aninhadas para itens (`/lists/:list_id/items`).
  - Endpoints adicionais para reordenação (`/lists/reorder`, `/lists/:list_id/items/reorder`, `/items/:id/move`).

- **Validações**:
  - Títulos obrigatórios, com comprimento entre 3 e 100 caracteres.
  - Descrição (List) até 500 caracteres.
  - Notas (Item) até 300 caracteres.

### Front‑end (Views + Hotwire)

- **Layout principal**: `application.html.erb` com classes Tailwind, container de flash com altura mínima fixa e cabeçalho com logo.
- **Kanban**: `index.html.erb` exibe todas as listas em colunas horizontais (flex, overflow‑x‑auto). Cada coluna é renderizada via partial `_list.html.erb`.
- **Drag-and-drop**:
  - O container `#board_lists` e cada `<ul id="lista_items_...">` possuem `data-controller="sortable"`.
  - SortableJS é inicializado via Stimulus, com suporte a scroll automático e filtro para o elemento “Nova Lista”.
- **Turbo Streams**: usados para atualizações em tempo real (criação, atualização, exclusão) sem recarregar a página.
- **Flash messages**: desaparecem após 3 segundos usando um Stimulus controller (`flash_message_controller.js`).

### Estilização

- Tailwind CSS é usado exclusivamente.
- Cores personalizadas: roxo (`purple-600`, `purple-700`) para botões principais, laranja (`orange-500`) para destaque do card “Nova Lista”.
- Layout responsivo com scroll horizontal para as colunas.

---

## Estrutura de Diretórios Relevante

```
app/
├── assets/
│   └── tailwind/application.css   # Configuração do Tailwind
├── controllers/
│   ├── lists_controller.rb
│   └── items_controller.rb
├── javascript/
│   ├── controllers/
│   │   ├── sortable_controller.js   # Controle de drag-and-drop
│   │   └── flash_message_controller.js # Auto-remoção de flash
├── models/
│   ├── list.rb
│   └── item.rb
├── views/
│   ├── lists/
│   │   ├── index.html.erb          # Kanban
│   │   ├── _list.html.erb          # Coluna de lista
│   │   ├── _form.html.erb          # Formulário de lista
│   │   ├── create.turbo_stream.erb
│   │   ├── destroy.turbo_stream.erb
│   │   └── error.turbo_stream.erb
│   ├── items/
│   │   ├── _item.html.erb          # Card do item
│   │   ├── _form.html.erb          # Formulário de item
│   │   ├── create.turbo_stream.erb
│   │   ├── update.turbo_stream.erb
│   │   ├── destroy.turbo_stream.erb
│   │   └── error.turbo_stream.erb
│   ├── shared/
│   │   └── _flash.html.erb
│   └── layouts/
│       └── application.html.erb
├── config/
│   ├── routes.rb
│   ├── database.yml
│   └── environments/production.rb   # Configurações para deploy
├── public/
│   └── images/logo.png              # Logo da aplicação
├── test/
│   ├── models/                      # Testes de modelos
│   ├── controllers/                 # Testes de controladores
│   └── system/                      # Testes de sistema
└── Gemfile
```

---

## Configuração do Ambiente

### Dependências

- Ruby (recomenda‑se `rbenv` com versão 3.2+)
- Bundler
- Node.js (para o Tailwind watcher)

### Instalação

```bash
git clone https://github.com/SEU_USUARIO/to_do_list.git
cd to_do_list
bundle install
rails db:create db:migrate
bin/dev   # Inicia Rails + Tailwind watcher
```

Acesse `http://localhost:3000`.

---

## Deploy no Render

- O arquivo `render.yaml` define o serviço web e o banco PostgreSQL.
- É necessário configurar a variável `RAILS_MASTER_KEY` no painel do Render com o conteúdo do `config/master.key` local.
- O `config/database.yml` utiliza `DATABASE_URL` em produção (fornecida pelo Render).

### Comandos úteis no Render

- Build command: `bundle install && bundle exec rake assets:precompile && bundle exec rake db:migrate`
- Start command: `bundle exec rails server -b 0.0.0.0 -p 10000`

---

## Testes

Os testes são escritos com o padrão do Rails (Minitest). Execute:

```bash
rails test              # testes unitários e de integração
rails test:system       # testes de sistema (Capybara)
```

Os testes de sistema cobrem o fluxo principal (criação de lista e item). Eles esperam os elementos exatos da interface atual (ex: placeholder “Nova tarefa...”, botão “Salvar”, etc.).

---

## Boas Práticas e Padrões de Código

### Comentários

- Todo código deve ser comentado em **português**, explicando a intenção de métodos e blocos importantes.
- Comentários devem ser claros e concisos.

### Nomenclatura

- Variáveis e métodos: `snake_case`.
- Models e controllers: PascalCase.
- Arquivos de partial: prefixo `_`.
- Nomes de branch: `feature/descricao`, `fix/descricao`.

### Segurança

- **Strong parameters** são utilizados em todos os controladores.
- **CSRF protection** está ativada por padrão (Rails).
- **Chave mestra** (`master.key`) nunca é commitada – está no `.gitignore`.
- Variáveis de ambiente sensíveis (ex: `DATABASE_URL`, `SECRET_KEY_BASE`) são definidas apenas no Render.
- Validações de comprimento evitam entradas excessivamente longas, prevenindo ataques de negação de serviço por dados grandes.

### Performance

- Utiliza `includes(:items)` na `index` para evitar consultas N+1.
- Índices adicionados nos campos `list_id`, `position`, `done`, `due_date` para otimizar buscas.
- O cache de assets é compilado uma única vez no deploy.

### Organização do Código

- **Controladores** são enxutos, usando `before_action` e `respond_to`.
- **Modelos** contêm apenas regras de negócio e validações.
- **Views** são compostas por partials reutilizáveis.
- **Turbo Streams** mantêm a lógica de atualização separada dos controladores.

---

## Uso de IA no Desenvolvimento

A inteligência artificial (ChatGPT, Gemini) foi utilizada para:

- Gerar esboços de código e refatorar.
- Sugerir melhores práticas de segurança e performance.
- Auxiliar na estruturação de issues e PRs.
- Validar a lógica de validações e testes.
- Elaborar a documentação.

Todas as sugestões foram revisadas manualmente e adaptadas ao contexto do projeto.

---

## Funcionalidades Implementadas

- [x] CRUD de listas e itens.
- [x] Interface estilo Kanban (colunas horizontais).
- [x] Drag-and-drop para reordenar listas e itens.
- [x] Movimentação de itens entre listas via arrastar e soltar.
- [x] Atualizações em tempo real com Turbo Streams.
- [x] Mensagens flash com auto‑remoção (3 segundos).
- [x] Validações no servidor (tamanhos, presença).
- [x] Responsividade com Tailwind.
- [x] Cores personalizadas (roxo e laranja).
- [x] API JSON para listas e itens.
- [x] Testes automatizados (modelos e sistema).
- [x] Deploy no Render com PostgreSQL.

---

## Possíveis Melhorias Futuras

- Autenticação de usuários (Devise) para listas privadas.
- Filtros por status ou data de vencimento.
- Notificações por e-mail para tarefas atrasadas.
- Melhorias de acessibilidade (ARIA labels, navegação por teclado).
- Adicionar campo `notes` no formulário de itens (atualmente não utilizado).
- Suporte a upload de imagens (Active Storage).

---

## Considerações Finais

Este projeto demonstra o uso integrado de Rails 8, Hotwire, Tailwind e SortableJS para criar uma aplicação moderna e interativa. A arquitetura favorece a manutenibilidade e a escalabilidade, mantendo o código simples e legível.

Qualquer alteração deve respeitar os padrões estabelecidos e ser acompanhada de testes adequados. A segurança das credenciais e dados do usuário deve ser sempre prioridade.
