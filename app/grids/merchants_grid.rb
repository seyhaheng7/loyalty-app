class MerchantsGrid

  include Datagrid

  scope do
    Merchant
  end

  filter(:name, :string)
  filter(:email, :string)


  column(:avatar, html: true) do |record|
    image_tag record.avatar, size: '150x150'
  end

  column(:name)
  column(:email)
  column(:phone)

  column(:actions, html:true) do |record|
    render 'users/control', user: record
  end
end
