FactoryGirl.define do
  factory :user do
    sequence(:email){ |n| "#{n}#{FFaker::Internet.email}" }
    password '1234567890'
    password_confirmation '1234567890'
  end
end
