class StoresGrid

  include Datagrid

  scope do
    Store.includes(:company, :location)
  end

  filter(:name, :string){ |value, scope| scope.name_like(value) }
  filter(:phone)
  filter(:website)
  filter(:company_id, :enum,
   :select => lambda {Company.pluck(:name, :id)})
  filter(:location_id, :enum,
   :select => lambda {Location.pluck(:name, :id)})

  column(:name)
  column(:address)

  column(:company) do |record|
    record.company_name
  end

  column(:location) do |record|
    record.location_name
  end

  column(:actions, html:true) do |record|
    render 'stores/control', store: record
  end

end
