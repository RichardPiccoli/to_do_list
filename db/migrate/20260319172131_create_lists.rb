class CreateLists < ActiveRecord::Migration[8.1]
  def change
    create_table :lists do |t|
      # Título da lista (campo obrigatório)
      t.string :title, null: false

      # Descrição opcional da lista
      t.text :description

      t.timestamps
    end

    # Índice para melhorar buscas por título (opcional, mas bom)
    add_index :lists, :title
  end
end