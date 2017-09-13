FactoryGirl.define do
  factory :merchant do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    phone { [8, 9].sample.times.map { rand(0..9) }.join }
    password 'Codingate@2017'
    password_confirmation 'Codingate@2017'
    association :store
  end
end
