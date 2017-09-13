class CategoriesGrid

  include Datagrid

  scope do
    Category
  end

  # filter(:id, :integer)
  # filter(:created_at, :date, :range => true)
  filter(:name, :string)

  column(:id)
  column(:name)
  column(:created_at) do |model|
    model.created_at.to_date
  end

  column(:actions, html:true) do |record|
    render 'categories/control', category: record
  end
end
