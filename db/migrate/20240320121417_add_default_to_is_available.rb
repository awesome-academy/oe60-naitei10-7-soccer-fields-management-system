class AddDefaultToIsAvailable < ActiveRecord::Migration[7.1]
  def change
    change_column_default :field_types, :is_availible, true
  end
end
