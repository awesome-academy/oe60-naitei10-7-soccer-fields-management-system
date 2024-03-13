# frozen_string_literal: true

module FieldTypesHelper
  def booking_hours(bookings = [])
    hours = []
    24.times do |hour|
      start_time = "#{hour.to_s.rjust(2, "0")}:00"
      end_time = "#{(hour + 1).to_s.rjust(2, "0")}:00"
      booked = bookings.any? { |booking| booking[:start_time] == start_time }
      hours << { start_time:, end_time:, booked: }
    end
    hours
  end
end
