class CustomersGrid

  include Datagrid

  scope do
    Customer
  end

  filter(:name, :string)
  filter(:email, :string)
  filter(:phone, :string)
  filter(:current_points, :integer, range: true)

  column(:avatar, html: true) do |record|
    image_tag record.avatar, size: '30x30'
  end

  column(:name)
  column(:email)
  column(:phone)
  column(:current_points)

  column(:actions, html:true) do |record|
    render 'customers/control', customer: record
  end

end





