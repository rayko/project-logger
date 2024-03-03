class CreateTodoItems < ActiveRecord::Migration[7.1]
  def change
    create_table :todo_items do |t|
      t.integer :project_id, null: false
      t.string :text, null: false
      t.boolean :checked, default: false

      t.index :project_id
      
      t.timestamps
    end
  end
end
