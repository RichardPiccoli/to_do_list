class Item < ApplicationRecord
  belongs_to :list

  # Ordenação
  scope :ordenados, -> { order(position: :asc) }

  # Validações
  validates :title,
            presence: { message: "não pode ficar vazio" },
            length: { minimum: 3, message: "deve ter pelo menos 3 caracteres" }

  validates :notes,
            length: { maximum: 300, message: "muito longa (máximo 300 caracteres)" },
            allow_blank: true
end