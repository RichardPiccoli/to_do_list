class Item < ApplicationRecord
  # Associação: item pertence a uma lista
  belongs_to :list

  # Validação: título obrigatório
  validates :title, presence: true

  # Validação: título mínimo
  validates :title, length: { minimum: 2 }

  # Scope para facilitar consultas (boa prática)
  # Retorna apenas itens concluídos
  scope :concluidos, -> { where(done: true) }

  # Retorna apenas itens pendentes
  scope :pendentes, -> { where(done: false) }

  # Ordenação por posição
  scope :ordenados, -> { order(position: :asc) }

  # Método para marcar como concluído
  def marcar_como_concluido
    update(done: true)
  end

  # Método para marcar como pendente
  def marcar_como_pendente
    update(done: false)
  end
end