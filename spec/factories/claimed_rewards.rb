FactoryGirl.define do
  factory :claimed_reward do
    status "submitted"
    association :customer
    association :reward

    trait :approved do
      status 'approved'
      association :managed_by, factory: :user
    end

    trait :rejected do
      status 'rejected'
      association :managed_by, factory: :user
    end

    trait :submitted do
      status 'submitted'
    end
  end
end
