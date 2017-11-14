FactoryGirl.define do
  factory :store_banner do
    image File.open('spec/support/700x300.png')
    association :store
  end
end
