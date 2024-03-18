# frozen_string_literal: true
module FieldsHelper
  # Shows which football fields this user has liked
  def check_is_user_favorited?(field)
    is_user_favorited = current_user.favorite_field_types.find do |f|
      f[:user_id] == current_user.id && f[:field_type_id] == field.id
    end
    is_user_favorited ? :heart : "heart-outline"
  end
end
