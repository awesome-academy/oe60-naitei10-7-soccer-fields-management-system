# frozen_string_literal: true

class Price < ApplicationRecord
  enum name: {
    Morning: "M",
    Afternoon: "A",
    Evening: "E"
  }

  belongs_to :field_type
  has_one :booking
end
