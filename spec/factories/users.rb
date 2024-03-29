# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    email { "nguyenthanhtung111xx@gmail.com" }
    first_name { "John" }
    last_name { "Doe" }
    phone_number { "123456789" }
    password { "Abc123$!" }
    password_confirmation { "Abc123$!" }
  end
end
