class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.integer :price_id
      t.string :name, limit: 50
      t.string :price, limit: 20

      t.timestamps
    end
    add_index :prices, :price_id
  end
end
