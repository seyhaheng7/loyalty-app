class CustomersGrid

  include Datagrid

  scope do
    Customer
  end

  filter(:name, :string){ |value, scope| scope.name_like(value) }
  filter(:email, :string)
  filter(:phone, :string)
  filter(:current_points, :integer, range: true)

  column(:avatar, html: true, order: false) do |record|
    image_tag record.avatar, size: '50x50'
  end

  column(:name, :order => "customers.first_name || customers.last_name") do |customer|
    customer.name
  end

  column(:email)
  column(:phone)
  column(:current_points)

  column(:actions, html:true) do |record|
    render 'customers/control', customer: record
  end

end





