# frozen_string_literal: true

class Field < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  has_many :field_types

  validates :image, content_type: { in: %w[image/jpeg image/gif image/png], message: I18n.t("model.field.image_invalid") }

  scope :sorted_by_name, -> { order :name }
  scope :search_by_name, lambda { |value_search|
    return if value_search.blank?

    where("name LIKE ?", "%#{value_search}%")
  }
end
