FactoryGirl.define do
  factory :video_ad do
    title "MyString"
    video_file File.open('spec/support/mov_bbb.mp4')
    thumbnail File.open('spec/support/default.png')
    start_date { Date.today - 10.days }
    end_date { Date.today + 10.days }
    earned_points 1
    max_view_per_day 2
  end
end
