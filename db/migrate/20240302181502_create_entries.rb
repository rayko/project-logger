class CreateEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :entries do |t|
      t.integer :project_id, null: false
      t.date :date, null: false
      t.text :body
      t.string :status, limit: 32, null: false
      t.float :hours
      
      t.timestamps
    end
  end
end
