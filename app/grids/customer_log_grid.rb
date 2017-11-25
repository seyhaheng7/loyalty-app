class CustomerLogGrid
  include Datagrid

  scope do
    Customer.includes(:operating_systems)
  end

  filter(:name, :string){ |value, scope| scope.name_like(value) }
  filter(:phone, :string)
  filter(:os, :enum, select: OperatingSystem::NAMES){ |value, scope| scope.joins(:operating_systems).where(operating_systems: { name: value }) }

  column(:name, html: true) do |record|
    link_to record.name, record
  end

  column(:phone)
  column(:last_sign_in_ip, header: 'IP')

  column(:os, header: 'OS') do |record|
    record.operating_systems.map(&:name).join(', ')
  end

  column(:language)


  column(:created_at, header: 'Date') do |record|
    record.created_at.to_date
  end

end
