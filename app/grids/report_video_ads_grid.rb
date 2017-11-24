class ReportVideoAdsGrid
  include Datagrid

  scope do
    VideoAd
  end

  filter(:title, :string, header: 'Company'){ |value, scope| scope.title_like(value) }
  filter(:date, :date, range: true) do |value, scope|
    start_date = value.first
    end_date  = value.second
    scope.active_between(start_date, end_date)
  end

  column(:title, header: 'Company') do |record|
    record.title
  end
  column(:start_date)
  column(:end_date)
  column(:earned_points, header: 'Point') do |record|
    record.earned_points
  end
  column(:view_video_ads, header: 'Rich view') do |record|
    record.view_video_ads.sum(:view_count)
  end

end
