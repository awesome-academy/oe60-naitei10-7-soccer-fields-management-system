# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :field_type
end
