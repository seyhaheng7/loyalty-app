FactoryGirl.define do
  factory :sticker_group do
    name "MyString"
    image File.open('spec/support/default.png')
  end
end
