class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.bigint :parent_comment_id, index: true
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end

    add_foreign_key :comments, :comments, column: :parent_comment_id
  end
end
