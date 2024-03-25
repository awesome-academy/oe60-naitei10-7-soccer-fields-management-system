# frozen_string_literal: true

class FieldType < ApplicationRecord
  belongs_to :field

  has_one_attached :image

  has_many :bookings, dependent: :destroy
  has_many :prices, dependent: :destroy

  validates :image, content_type: { in: %w[image/jpeg image/gif image/png], message: I18n.t("model.field.image_invalid") }

  delegate :description, :address, :phone_number, to: :field, prefix: true
end
