class List < ApplicationRecord
  # Associação: uma lista possui vários itens
  has_many :items, dependent: :destroy
  # dependent: :destroy garante que ao apagar uma lista,
  # todos os itens associados também serão removidos

  # Validação: título é obrigatório
  validates :title, presence: true

  # Validação: título deve ter tamanho mínimo
  validates :title, length: { minimum: 3 }

  # Método auxiliar (boa prática)
  # Retorna apenas itens não concluídos
  def itens_pendentes
    items.where(done: false)
  end

  # Retorna itens concluídos
  def itens_concluidos
    items.where(done: true)
  end
end