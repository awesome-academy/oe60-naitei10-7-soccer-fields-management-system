# frozen_string_literal: true
require "rufus-scheduler"

scheduler = Rufus::Scheduler.new
scheduler.cron "0 0 1 * *" do
  ReportsController.send_monthly_report
end
