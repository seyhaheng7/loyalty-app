FactoryGirl.define do
  factory :contact_form do
    subject "Can't Claimed Reward"
    message "Please Contact Back"
    association :customer
  end
end
