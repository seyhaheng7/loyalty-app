class VideoAdsGrid

  include Datagrid

  scope do
    VideoAd
  end

  filter(:title, :string)

  column(:title)
  # column(:video)
  column(:actions, html:true) do |record|
    render 'video_ads/control', video_ad: record
  end
end
