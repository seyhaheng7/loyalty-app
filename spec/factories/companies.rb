FactoryGirl.define do
  factory :company do
    name "MyString"
    address "MyString"
    point_rate 1
    logo "MyString"
    association :category
  end
end
