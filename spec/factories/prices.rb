# frozen_string_literal: true
FactoryBot.define do
  factory :price do
    name { "M" }
    price { "200" }
    field_type_id { 1 }
  end
end
