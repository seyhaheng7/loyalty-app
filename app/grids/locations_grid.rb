class LocationsGrid
  include Datagrid
  filter(:name, :string)
  scope do
    Location
  end

  column(:name)

  column(:actions, html:true) do |record|
    render 'locations/control', location: record
  end
end
