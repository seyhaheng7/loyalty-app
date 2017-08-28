FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    uid { FFaker::Internet.email }
    password 'Codingate@2017'
    password_confirmation 'Codingate@2017'
  end
end
