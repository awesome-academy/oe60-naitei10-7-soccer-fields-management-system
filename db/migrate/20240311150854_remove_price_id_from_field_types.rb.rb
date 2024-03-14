class RemovePriceIdFromFieldTypes < ActiveRecord::Migration[7.1]
  def change
    remove_reference :field_types, :price, foreign_key: true
  end
end
