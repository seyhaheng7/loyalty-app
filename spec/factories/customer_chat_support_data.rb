FactoryGirl.define do
  factory :customer_chat_support_datum do
    text "MyText"
    supportable_id 1
    supportable_type "MyString"
    association :customer_chat_support
  end
end
