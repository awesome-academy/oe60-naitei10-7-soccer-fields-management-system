# frozen_string_literal: true

class Field < ApplicationRecord
  scope :sorted_by_name, -> { order :name }
end
