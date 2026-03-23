class List < ApplicationRecord
  has_many :items, dependent: :destroy

  # Ordenação padrão por posição
  default_scope { order(position: :asc) }

  # Validações
  validates :title,
            presence: { message: "não pode ficar vazio" },
            length: {
              minimum: 3,
              maximum: 100,
              message: "deve ter entre 3 e 100 caracteres"
            }

  validates :description,
            length: { maximum: 500, message: "muito longa (máximo 500 caracteres)" },
            allow_blank: true
end
