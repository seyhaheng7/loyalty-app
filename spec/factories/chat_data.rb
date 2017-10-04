FactoryGirl.define do
  factory :chat_datum do
    text "MyText"
    all_recieved false
    association :chat_room
    association :customer
  end
end
