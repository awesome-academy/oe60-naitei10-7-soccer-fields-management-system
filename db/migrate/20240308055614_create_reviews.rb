class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer :review_id
      t.integer :rating
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :field, null: false, foreign_key: true

      t.timestamps
    end
    add_index :reviews, :review_id
  end
end
