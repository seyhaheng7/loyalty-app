class CompaniesGrid

  include Datagrid

  scope do
    Company
  end

  filter(:name, :string)
  filter(:address, :string)

  column(:name)
  column(:address)

  column(:actions, html:true) do |record|
    render 'companies/control', company: record
  end

end
