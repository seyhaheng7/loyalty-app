FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    uid { FFaker::Internet.email }
    role 'Admin'
    password 'Codingate@2017'
    password_confirmation 'Codingate@2017'

    trait :admin do
      'Admin'
    end

    trait :super do
      'Super'
    end

    trait :customer do
      'Customer'
    end

    trait :merchant do
      'Merchant'
    end
  end
end
