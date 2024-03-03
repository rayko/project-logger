class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, limit: 128
      t.string :password_digest
      t.string :name
      t.boolean :admin, default: false
      t.index :email
      
      t.timestamps
    end
  end
end
