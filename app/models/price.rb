# frozen_string_literal: true

class Price < ApplicationRecord
  belongs_to :field_type
  has_one :booking
end
