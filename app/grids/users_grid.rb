class UsersGrid

  include Datagrid

  scope do
    User
  end

  filter(:name, :string)
  filter(:role, :string)
  filter(:email, :string)


  column(:avatar, html: true) do |record|
    image_tag record.avatar, size: '30x30'
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
