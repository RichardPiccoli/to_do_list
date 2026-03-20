class CreateItems < ActiveRecord::Migration[8.1]
  def change
    create_table :items do |t|
      # Título da tarefa (obrigatório)
      t.string :title, null: false

      # Notas adicionais
      t.text :notes

      # Indica se a tarefa foi concluída
      # Default false = tarefa começa como não concluída
      t.boolean :done, default: false, null: false

      # Data limite da tarefa
      t.datetime :due_date

      # Posição da tarefa na lista (para ordenação futura)
      t.integer :position

      # Referência para a lista (chave estrangeira)
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end

    # Índices importantes para performance
    add_index :items, :done
    add_index :items, :due_date
    add_index :items, [ :list_id, :position ]
  end
end
