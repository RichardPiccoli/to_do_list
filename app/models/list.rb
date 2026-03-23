class List < ApplicationRecord
  # Associação: lista pertence a um usuário (opcional para compatibilidade com registros antigos)
  belongs_to :user, optional: true
  # Associação: uma lista possui vários itens; ao excluir a lista, os itens são removidos
  has_many :items, dependent: :destroy

  # Ordenação padrão por posição
  default_scope { order(position: :asc) }

  # Validação: título obrigatório, entre 3 e 100 caracteres
  validates :title,
            presence: { message: "não pode ficar vazio" },
            length: {
              minimum: 3,
              maximum: 100,
              message: "deve ter entre 3 e 100 caracteres"
            }

  # Validação: descrição opcional, no máximo 500 caracteres
  validates :description,
            length: { maximum: 500, message: "muito longa (máximo 500 caracteres)" },
            allow_blank: true
end
