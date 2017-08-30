class StoresGrid

  include Datagrid

  scope do
    Store
  end

  filter(:name, :string)

  column(:id)
  column(:name)
  column(:created_at) do |model|
    model.created_at.to_date
  end

  column(:actions, html:true) do |record|
    render 'stores/control', store: record
  end

end
