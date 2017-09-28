FactoryGirl.define do
  factory :customer_chat_support_datum do
    text "MyText"
    supportable_id 1
    supportable_type "MyString"
    customer_chat_support nil
  end
end
