FactoryGirl.define do
  factory :advertisement do
    name "MyString"
    banner File.open('spec/support/default.png')
    active false
    for_page "MyString"
    address "MyString"
    phone "MyString"
    website "MyString"
    start_date Date.today
    end_date Date.tomorrow
  end
end
