FactoryGirl.define do
  factory :merchant do
    email { FFaker::Internet.email }
    name { FFaker::Name.name }
    password 'Codingate@2017'
    phone '1234567890'
    password_confirmation 'Codingate@2017'
    association :store
  end
end
