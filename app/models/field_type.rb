# frozen_string_literal: true

class FieldType < ApplicationRecord
  belongs_to :field

  has_many :bookings
  has_many :prices

  delegate :description, :address, :phone_number, to: :field, prefix: true
end
