# frozen_string_literal: true

class Booking < ApplicationRecord
  enum status: {
    pending: 1,
    confirmed: 2,
    canceled: 3
  }, _default: :pending

  attribute :booked_date, :date, default: -> { Date.current }

  belongs_to :user
  belongs_to :field_type
end
