FactoryGirl.define do
  factory :claimed_reward do
    status "submitted"
    association :user
    association :reward
  end
end
