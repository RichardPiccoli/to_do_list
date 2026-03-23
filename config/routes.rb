Rails.application.routes.draw do
  resources :lists do
    resources :items do
      patch :reorder, on: :collection # PATCH /lists/:list_id/items/reorder
    end
    patch :reorder, on: :collection   # Para reordenar listas
  end

  # Para mover um item para outra lista
  resources :items do
    patch :move, on: :member
  end

  root "lists#index"
end
