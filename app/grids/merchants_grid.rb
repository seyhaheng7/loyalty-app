class MerchantsGrid

  include Datagrid

  scope do
    Merchant
  end

  filter(:name, :string){ |value, scope| scope.name_like(value) }
  filter(:email, :string)
  filter(:phone, :string)


  column(:name)
  column(:avatar, html: true, order: false) do |record|
    image_tag record.avatar, size: '50x50'
  end
  column(:email)
  column(:phone)

  column(:actions, html:true) do |record|
    render 'users/control', user: record
  end
end
