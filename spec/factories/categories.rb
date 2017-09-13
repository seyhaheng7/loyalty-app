FactoryGirl.define do
  factory :category do
    name { FFaker::Name.name }
    icon "MyString"
  end
end
