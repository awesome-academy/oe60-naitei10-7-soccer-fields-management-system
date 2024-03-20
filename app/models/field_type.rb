# frozen_string_literal: true

class FieldType < ApplicationRecord
  belongs_to :field

  has_many :bookings, dependent: :destroy
  has_many :prices, dependent: :destroy

  delegate :description, :address, :phone_number, to: :field, prefix: true
end
