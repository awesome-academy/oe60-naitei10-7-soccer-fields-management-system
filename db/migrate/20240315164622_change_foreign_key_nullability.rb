class ChangeForeignKeyNullability < ActiveRecord::Migration[7.1]
  def change
    change_column_null :comments, :review_id, true
  end
end
