FactoryGirl.define do
  factory :notification do
    notification_type "SubmittedReceipt"
    text "MyString"
    association :notifyable, factory: :user
    association :objectable, factory: :receipt 
  end
end