# frozen_string_literal: true

module FieldTypesHelper
  def booking_hours
    hours = []
    24.times do |hour|
      start_time = "#{hour.to_s.rjust(2, "0")}:00"
      end_time = "#{(hour + 1).to_s.rjust(2, "0")}:00"
      booked = @field_types_booked.any? { |booking| booking[:start_time] == start_time && !booking.canceled? }
      hours << { start_time:, end_time:, booked: }
    end
    hours
  end

  def field_type_status(field_type)
    field_type.is_availible ? :success : :danger
  end

  def field_type_label_button_status(field_type)
    field_type.is_availible ? t("button.availible_field") : t("button.inavailible_field")
  end
end
