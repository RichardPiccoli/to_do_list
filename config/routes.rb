Rails.application.routes.draw do
  resources :lists do
    resources :items
    patch :reorder, on: :collection   # Para reordenar listas
  end

  # Para reordenar itens dentro de uma lista
  resources :items do
    patch :move, on: :member          # Para mover um item para outra lista
  end

  root "lists#index"
end
