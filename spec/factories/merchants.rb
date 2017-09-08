FactoryGirl.define do
  factory :merchant do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    phone { FFaker::PhoneNumber.short_phone_number }
    password 'Codingate@2017'
    password_confirmation 'Codingate@2017'
    association :store
  end
end
