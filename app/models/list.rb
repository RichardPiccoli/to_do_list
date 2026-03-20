class List < ApplicationRecord
  has_many :items, dependent: :destroy

  # Validações
  validates :title,
            presence: { message: "não pode ficar vazio" },
            length: { minimum: 3, message: "deve ter pelo menos 3 caracteres" }

  validates :description,
            length: { maximum: 500, message: "muito longa (máximo 500 caracteres)" },
            allow_blank: true
end
