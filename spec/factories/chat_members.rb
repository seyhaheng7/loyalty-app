FactoryGirl.define do
  factory :chat_member do
    association :customer
    association :chat_room
  end
end
