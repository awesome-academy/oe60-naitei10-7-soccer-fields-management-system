class CreateFavoriteFieldTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :favorite_field_types do |t|
      t.references :field_type, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
