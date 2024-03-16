# frozen_string_literal: true
class FavoriteFieldType < ApplicationRecord
  belongs_to :field_type
  belongs_to :user
end
