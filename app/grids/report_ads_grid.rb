class ReportAdsGrid
  include Datagrid

  scope do
    Advertisement
  end


  filter(:date, :date, range: true) do |value, scope|
    start_date = value.first
    end_date  = value.second
    scope.active_between(start_date, end_date)
  end

  column :name
  column(:picture, html: true) do |record|
    image_tag record.banner, size: '50x50'
  end
  column(:start_date)
  column(:end_date)
  column(:price, html: true) do |record|
    number_to_currency record.price
  end
  column(:position, html: true) do |record|
    record.for_page
  end
  column(:status, html: true) do |record|
    record.active
  end
  column(:view)


end
