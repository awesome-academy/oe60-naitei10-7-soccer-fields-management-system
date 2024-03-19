# frozen_string_literal: true
module Admin
  class BookingMailer < ApplicationMailer
    def booking_accepted_email(booking)
      @booking = booking
      mail(to: booking.user.email, subject: t("email.activation.booking"))
    end

    def booking_rejected_email(booking)
      @booking = booking
      mail(to: booking.user.email, subject: t("email.activation.booking"))
    end
  end
end
