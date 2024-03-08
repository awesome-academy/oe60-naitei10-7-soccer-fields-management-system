class CreateFields < ActiveRecord::Migration[7.1]
  def change
    create_table :fields do |t|
      t.string :name, limit: 50
      t.text :description
      t.string :phone_number, limit: 15
      t.string :address, limit: 50

      t.timestamps
    end
    add_index :fields, :id
  end
end
