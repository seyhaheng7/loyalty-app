class AdvertisementsGrid

  include Datagrid

  scope do
    Advertisement
  end

  filter(:name, :string){ |value, scope| scope.name_like(value) }
  filter(:phone, :string)
  filter(:address, :string){ |value, scope| scope.address_like(value) }

  column(:name)
  column(:banner, html: true, order: false) do |record|
    image_tag record.banner, size: '50x50'
  end
  column(:for_page, header: 'Page')
  column(:price)
  column(:active)
  column(:phone, order: false)

  # column(:created_at) do |model|
  #   model.created_at.to_date
  # end
  column(:actions, html:true) do |record|
    render 'advertisements/control', advertisement: record
  end
end
