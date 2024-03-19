# frozen_string_literal: true
class BillingMailer < ApplicationMailer
  def revenue_report(admin, total_amount)
    @total_amount = total_amount
    mail(to: admin.email, subject: t("email.report"))
  end
end
