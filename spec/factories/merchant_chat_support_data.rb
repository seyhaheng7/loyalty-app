FactoryGirl.define do
  factory :merchant_chat_support_datum do
    text "MyText"
    supportable_id 1
    supportable_type "MyString"
    association :merchant_chat_support
  end
end
