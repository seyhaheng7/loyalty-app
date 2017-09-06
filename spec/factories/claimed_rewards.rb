FactoryGirl.define do
  factory :claimed_reward do
    status "submitted"
    association :customer
    association :reward
  end
end
