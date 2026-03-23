class AddPositionToLists < ActiveRecord::Migration[8.1]
  def change
    add_column :lists, :position, :integer, null: false, default: 0

    # Adiciona índice para melhor performance nas consultas ordenadas
    add_index :lists, :position
  end
end
