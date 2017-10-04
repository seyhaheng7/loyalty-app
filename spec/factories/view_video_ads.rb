FactoryGirl.define do
  factory :view_video_ad do
    date "2017-10-02"
    view_count 1
    association :video_ad
    association :customer
  end
end
