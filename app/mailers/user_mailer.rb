# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("email.activation.subject")
  end

  def cancel_booking_success
    mail to: ENV["ADMIN_EMAIL"], subject: t("email.cancel_booking.success")
  end
end
