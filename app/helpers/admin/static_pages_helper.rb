# frozen_string_literal: true

module Admin
  module StaticPagesHelper
    def bookings_get
      current_user.fields.flat_map { |field| field.field_types.flat_map(&:bookings) }
    end
  end
end
