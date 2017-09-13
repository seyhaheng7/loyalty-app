FactoryGirl.define do
  factory :customer do
    phone { [8, 9].sample.times.map { rand(0..9) }.join }
    verified_at { DateTime.now }
    first_name 'jonh'
    last_name 'wick'
    password 'Codingate@2017'
    password_confirmation 'Codingate@2017'

    trait :unverified do
      verified_at nil
    end

  end
end
