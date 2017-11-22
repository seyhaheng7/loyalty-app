FactoryGirl.define do
  factory :sticker do
    name "MyString"
    image File.open('spec/support/Pik.png')
    association :sticker_group
  end
end
