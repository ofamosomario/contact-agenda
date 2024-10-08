# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber }
    zip_code { '69985-970' }
    address { Faker::Address.full_address }
  end
end
