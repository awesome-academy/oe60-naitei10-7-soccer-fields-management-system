# frozen_string_literal: true
class ReportsController < ApplicationController
  def self.send_monthly_report
    admins = User.admin.with_revenue_report
    admins.each do |admin|
      BillingMailer.revenue_report(admin, admin.total_amount).deliver_now
    end
  end
end
