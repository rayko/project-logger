class CreateResourceLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :resource_links do |t|
      t.string :title, null: false
      t.text :link, null: false
      t.integer :project_id, null: false

      t.timestamps
    end
  end
end
