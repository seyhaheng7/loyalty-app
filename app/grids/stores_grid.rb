class StoresGrid

  include Datagrid

  scope do
    Store
  end

  filter(:name, :string)

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
