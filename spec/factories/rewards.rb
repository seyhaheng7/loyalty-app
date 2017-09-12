FactoryGirl.define do
  factory :reward do
    name "CodingAte"
    image File.open('spec/support/default.png')
    require_points 1
    quantity 4
    association :store
  end
end
