FactoryGirl.define do
  factory :customer do
    phone { FFaker::PhoneNumber.short_phone_number }
    password 'Codingate@2017'
    password_confirmation 'Codingate@2017'

  end
end
