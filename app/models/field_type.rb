# frozen_string_literal: true

class FieldType < ApplicationRecord
  belongs_to :field
  belongs_to :price
end
