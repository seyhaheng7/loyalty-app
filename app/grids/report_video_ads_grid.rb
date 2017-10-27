class ReportVideoAdsGrid
  include Datagrid

  scope do
    VideoAd
  end

  filter(:title, :string)

  filter(:date, :date, range: true) do |value, scope|
    start_date = value.first
    end_date  = value.second
    scope.active_between(start_date, end_date)
  end

  column(:title) do |record|
    record.title
  end
  column(:start_date)
  column(:end_date)
  column(:point) do |record|
    record.earned_points
  end
  column(:rich_view) do |record|
    record.view_video_ads.sum(:view_count)
  end

end
