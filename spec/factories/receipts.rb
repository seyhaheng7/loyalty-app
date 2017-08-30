FactoryGirl.define do
  factory :receipt do
    receipt_id "MyString"
    total 1.5
    capture File.open('spec/support/default.png')
    earned_points 1
    status "MyString"
    association :store
    association :user
  end
end
