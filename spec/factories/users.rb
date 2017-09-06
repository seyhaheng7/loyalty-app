FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    name { FFaker::Name.name }
    password 'Codingate@2017'
    password_confirmation 'Codingate@2017'
    role 'Admin'
    trait :admin do
      role 'Admin'
    end


    trait :super do
      role 'Super'
    end
  end
end
