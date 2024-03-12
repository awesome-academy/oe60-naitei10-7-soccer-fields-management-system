# frozen_string_literal: true

module FieldTypesHelper
  def booking_hours
    hours = []
    24.times do |hour|
      start_time = "#{hour.to_s.rjust(2, "0")}:00"
      end_time = "#{(hour + 1).to_s.rjust(2, "0")}:00"
      hours << { start_time:, end_time: }
    end
    hours
  end
end
