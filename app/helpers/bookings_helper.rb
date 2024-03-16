# frozen_string_literal: true
module BookingsHelper
  def check_status_booking(booking)
    if booking.pending?
      :primary
    else
      booking.confirmed? ? :success : :danger
    end
  end
end
