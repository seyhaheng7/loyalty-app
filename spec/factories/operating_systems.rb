FactoryGirl.define do
  factory :operating_system do
    name { ['android', 'ios'].sample }
    association :customer
  end
end
