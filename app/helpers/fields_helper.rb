module FieldsHelper
  def map_fields_with_bookings?(field, favorites, current_user_id)
    favorites.find { |f| f[:user_id] == current_user_id && f[:field_type_id] == field.id }
  end
end
