FactoryGirl.define do
  factory :reward do
    name { FFaker::Name.name }
    image File.open('spec/support/default.png')
    require_points 1
    quantity 4
    association :store

    start_date Date.today - 10.days
    end_date Date.today + 10.days
    trait :active do
      start_date Date.today - 10.days
      end_date Date.today + 10.days
    end

    trait :inactive do
      start_date Date.today + 10.days
      end_date Date.today + 20.days
    end

    trait :available do
      quantity 4
      approved_claimed_rewards_count 2
    end
  end
end
