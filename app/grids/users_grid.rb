class UsersGrid

  include Datagrid

  scope do
    User
  end

  filter(:name, :string){ |value, scope| scope.name_like(value) }
  filter(:role, :enum,  select: User::ROLES)
  filter(:email, :string)


  column(:avatar, html: true) do |record|
    image_tag record.avatar, size: '50x50'
  end

  column(:name)
  column(:role)
  column(:email)

  # column(:created_at) do |model|
  #   model.created_at.to_date
  # end
  column(:actions, html:true) do |record|
    render 'users/control', user: record
  end
end
