class AdvertisementsGrid

  include Datagrid

  scope do
    Advertisement
  end

  filter(:name, :string)
  filter(:phone, :string)
  filter(:address, :string)

  column(:name)
  column(:banner)
  column(:active)
  column(:address)
  column(:phone)

  # column(:created_at) do |model|
  #   model.created_at.to_date
  # end
  column(:actions, html:true) do |record|
    render 'advertisements/control', advertisement: record
  end
end
