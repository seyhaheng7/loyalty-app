FactoryGirl.define do
  factory :location do
    name { FFaker::Name.name }
    description "MyText"
  end
end
