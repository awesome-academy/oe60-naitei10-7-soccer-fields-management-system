class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, limit: 50
      t.string :first_name, limit: 20
      t.string :last_name, limit: 20
      t.string :phone_number, limit: 15
      t.string :password_digest
      t.boolean :is_active
      t.integer :role

      t.timestamps
    end
    add_index :users, :id
  end
end
