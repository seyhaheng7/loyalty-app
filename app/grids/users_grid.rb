class UsersGrid

  include Datagrid

  scope do
    User
  end

  filter(:name, :string)
  filter(:email, :string)
  column(:avatar, html: true) do |record|
    image_tag record.avatar, size: '150x150'
  end
  
  
  column(:name)
  column(:email)
  # column(:created_at) do |model|
  #   model.created_at.to_date
  # end
  column(:options, html:true) do |record|
    render 'users/control', user: record
  end  
end
