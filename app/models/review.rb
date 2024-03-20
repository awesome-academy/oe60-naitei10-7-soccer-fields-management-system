# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :field_type
  has_many :comments

  scope :review_records, ->(field_type_id) { where(field_type_id:).order(created_at: :desc) }
end
