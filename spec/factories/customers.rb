FactoryGirl.define do
  factory :customer do
    phone { FFaker::PhoneNumber.short_phone_number }
    verified_at { DateTime.now }
    password 'Codingate@2017'
    password_confirmation 'Codingate@2017'

    trait :unverified do
      verified_at nil
    end

  end
end
