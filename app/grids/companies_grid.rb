class CompaniesGrid

  include Datagrid

  scope do
    Company
  end

  filter(:name, :string){ |value, scope| scope.name_like(value) }

  column(:name)
  column(:address)

  column(:actions, html:true) do |record|
    render 'companies/control', company: record
  end

end
