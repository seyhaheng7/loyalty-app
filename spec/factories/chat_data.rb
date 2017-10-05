FactoryGirl.define do
  factory :chat_datum do
    text nil
    sticker nil
    all_recieved false
    association :chat_room
    association :customer

    trait :data_type_text do
      text 'MyText'
    end

    trait :data_type_sticker do
      sticker 'http://localhost:3000/stickers/1'
    end

  end
end
