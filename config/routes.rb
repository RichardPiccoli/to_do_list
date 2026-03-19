Rails.application.routes.draw do
  # Rotas para listas
  resources :lists do
    # Rotas aninhadas para itens dentro de listas
    resources :items
  end

  # Define a página inicial como lista de listas
  root "lists#index"
end