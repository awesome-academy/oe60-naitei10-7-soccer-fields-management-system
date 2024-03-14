class AddFieldTypeToPrices < ActiveRecord::Migration[7.1]
  def change
    add_reference :prices, :field_type, null: false, foreign_key: true
  end
end
