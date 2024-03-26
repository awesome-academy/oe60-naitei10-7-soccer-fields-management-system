# frozen_string_literal: true

class Booking < ApplicationRecord
  enum status: {
    pending: 1,
    confirmed: 2,
    canceled: 3
  }, _default: :pending

  attribute :booked_date, :date, default: -> { Date.current }
  attribute :rating, :integer, default: 5

  belongs_to :user
  belongs_to :field_type
  belongs_to :price, foreign_key: :price_id

  scope :latest, -> { order(created_at: :desc) }
  scope :by_ids, ->(ids) { where(id: ids) }

  delegate :field_type_name, :prices, :field, to: :field_type
  delegate :address, :name, to: :field
end
