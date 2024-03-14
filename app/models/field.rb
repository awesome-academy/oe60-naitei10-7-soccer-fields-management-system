# frozen_string_literal: true

class Field < ApplicationRecord
  belongs_to :user
  
  has_many :field_types
  
  scope :sorted_by_name, -> { order :name }
  scope :search_by_name, lambda { |value_search|
    return if value_search.blank?

    where("name LIKE ?", "%#{value_search}%")
  }
end
