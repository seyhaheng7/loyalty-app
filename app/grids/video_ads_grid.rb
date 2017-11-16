class VideoAdsGrid

  include Datagrid

  scope do
    VideoAd
  end

  filter(:title, :string){ |value, scope| scope.title_like(value) }


  column(:title)
  # we use thumbnails because bootstrap has a class thumbnail
  column(:thumbnails, html: true) do |reward|
    image_tag reward.thumbnail, size: '50x50'
  end
  column(:max_view_per_day)
  column(:start_date)
  column(:end_date)
  column(:actions, html:true) do |record|
    render 'video_ads/control', video_ad: record
  end
end
