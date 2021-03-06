class CompaniesGrid

  include Datagrid

  scope do
    Company
  end

  filter(:name, :string){ |value, scope| scope.name_like(value) }
  filter(:phone)
  filter(:category_id, :enum, :select => lambda {Category.pluck(:name, :id)})


  column(:name)
  column(:contact_name)
  column(:email)
  column(:phone)

  column(:actions, html:true) do |record|
    render 'companies/control', company: record
  end

end
