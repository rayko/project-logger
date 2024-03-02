class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string   :name,         limit: 128
      t.text     :description,  limit: 4096
      t.string   :status,       limit: 32,   null: false
      t.boolean  :locked,       default: false
      t.datetime :locked_at
      # t.integer  :user_id,                  null: false

      t.timestamps
    end
  end
end
