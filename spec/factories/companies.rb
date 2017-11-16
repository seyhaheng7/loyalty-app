FactoryGirl.define do
  factory :company do
    name { FFaker::Name.name }
    address "MyString"
    logo File.open('spec/support/img(250166).jpg')
    association :category
    partner true
  end
end
