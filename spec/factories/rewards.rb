FactoryGirl.define do
  factory :reward do
    name "MyString"
    image File.open('spec/support/default.png')
    require_points 1
    quantity 1
    association :company
  end
end
