class PromotionsGrid

  include Datagrid

  scope do
    Promotion
  end

  filter(:title, :string)
  filter(:date, :date, range: true) do |value, scope|
    start_date = value.first
    end_date  = value.second
    scope.active_between(start_date, end_date)
  end

  column(:title)
  column(:sent)
  column(:image, html: true, order: false) do |promotion|
    image_tag promotion.image, size: '50x50'
  end
  column(:start_date)
  column(:end_date)

  column(:actions, html:true) do |record|
    render 'promotions/control', promotion: record
  end
end
