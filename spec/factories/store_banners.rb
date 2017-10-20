FactoryGirl.define do
  factory :store_banner do
    image File.open('spec/support/default.png')
    association :store
  end
end
