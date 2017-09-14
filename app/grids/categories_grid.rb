class CategoriesGrid

  include Datagrid

  scope do
    Category
  end

  filter(:name, :string){ |value| scope.name_like(value) }

  column(:id)
  column(:name)
  column(:created_at) do |model|
    model.created_at.to_date
  end

  column(:actions, html:true) do |record|
    render 'categories/control', category: record
  end
end
