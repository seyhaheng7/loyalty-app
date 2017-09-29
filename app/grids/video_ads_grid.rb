class VideoAdsGrid

  include Datagrid

  scope do
    VideoAd
  end

  filter(:title, :string)

  column(:title)
  column(:max_view_per_day)
  column(:start_date)
  column(:end_date)
  column(:actions, html:true) do |record|
    render 'video_ads/control', video_ad: record
  end
end
