class PromotionsGrid

  include Datagrid

  scope do
    Promotion
  end

  filter(:title, :string)
  filter(:start_date, :date)
  filter(:end_date, :date)

  column(:title)
  column(:image, html: true) do |promotion|
    image_tag promotion.image, size: '30x30'
  end
  column(:start_date)
  column(:end_date)

  column(:actions, html:true) do |record|
    render 'promotions/control', promotion: record
  end
end
