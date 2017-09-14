class LocationsGrid
  include Datagrid
  scope do
    Location
  end

  filter(:name, :string){ |value, scope| scope.name_like(value) }

  column(:name)
  column(:actions, html:true) do |record|
    render 'locations/control', location: record
  end
end
