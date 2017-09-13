FactoryGirl.define do
  factory :company do
    name "MyString"
    address "MyString"
    logo "MyString"
    association :category
    partner true
  end
end
