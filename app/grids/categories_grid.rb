class CategoriesGrid

  include Datagrid

  scope do
    Category
  end

  filter(:name, :string){ |value, scope| scope.name_like(value) }

  column(:drag_zone, header: '', html: true) do
    fa_icon 'arrows', class: 'draggable'
  end
  column(:name, order: false)
  column(:created_at, order: false) do |model|
    model.created_at.to_date
  end

  column(:actions, html:true) do |record|
    render 'categories/control', category: record
  end

  def row_data(object)
    { id: object.id }
  end
end
