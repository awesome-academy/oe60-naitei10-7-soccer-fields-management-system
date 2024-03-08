class CreateFieldTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :field_types do |t|
      t.string :field_type_name, limit: 50
      t.boolean :is_availible
      t.references :field, null: false, foreign_key: true
      t.references :price, null: false, foreign_key: true

      t.timestamps
    end
    add_index :field_types, :id
  end
end
