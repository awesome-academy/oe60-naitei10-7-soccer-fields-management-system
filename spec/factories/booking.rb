# frozen_string_literal: true
FactoryBot.define do
  factory :booking do
    start_time { "13:00" }
    end_time { "14:00" }
    status { 1 }
    booked_date { "2024-12-12" }
  end
end
