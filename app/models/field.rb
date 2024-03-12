# frozen_string_literal: true

class Field < ApplicationRecord
  has_many :field_types
  scope :sorted_by_name, -> { order :name }
end
