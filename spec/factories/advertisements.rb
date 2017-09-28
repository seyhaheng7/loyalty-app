FactoryGirl.define do
  factory :advertisement do
    name "MyString"
    banner File.open('spec/support/default.png')
    active false
    for_page "MyString"
    lat "MyString"
    long "MyString"
    address "MyString"
    phone "MyString"
    web_site "MyString"
    start_date "2017-09-25"
    end_date "2017-09-25"
  end
end
