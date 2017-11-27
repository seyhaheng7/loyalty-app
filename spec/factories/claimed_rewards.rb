FactoryGirl.define do
  factory :claimed_reward do
    association :customer
    association :reward
  end
end
