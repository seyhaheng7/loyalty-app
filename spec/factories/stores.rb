FactoryGirl.define do
  factory :store do
    name "MyString"
    lat 1.5
    long 1.5
    address "MyString"
    association :company
    association :location
  end
end
