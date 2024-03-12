class RemovePriceIdFromFieldTypes < ActiveRecord::Migration[7.1]
  def change
    remove_reference :field_type, :price, null: false, foreign_key: true
  end
end
