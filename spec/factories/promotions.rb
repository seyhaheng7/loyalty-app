FactoryGirl.define do
  factory :promotion do
    title "MyString"
    image "MyString"
    body "MyText"
    start_date Date.today
    end_date Date.tomorrow
  end
end
