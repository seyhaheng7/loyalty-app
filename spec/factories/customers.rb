FactoryGirl.define do
  factory :customer do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    phone { [8, 9].sample.times.map { rand(0..9) }.join }
    verified_at { DateTime.now }
    password 'Codingate@2017'
    password_confirmation 'Codingate@2017'
    current_points 1000
    trait :unverified do
      verified_at nil
    end

  end
end
