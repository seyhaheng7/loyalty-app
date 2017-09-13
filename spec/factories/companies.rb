FactoryGirl.define do
  factory :company do
    name { FFaker::Name.name }
    address "MyString"
    logo "MyString"
    association :category
    partner true
  end
end
