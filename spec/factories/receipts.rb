FactoryGirl.define do
  factory :receipt do
    receipt_id "MyString"
    total 1.5
    capture File.open('spec/support/default.png')
    earned_points 1
    status "submitted"
    association :store
    association :customer
  end
end
