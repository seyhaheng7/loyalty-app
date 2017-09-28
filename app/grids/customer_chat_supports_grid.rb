class CustomerChatSupportsGrid

  include Datagrid

  scope do
    CustomerChatSupport
  end

  filter(:id, :integer)
  filter(:created_at, :date, :range => true)

  column(:id)
  column(:customer_id)

  column(:created_at) do |model|
    model.created_at.to_date
  end

  column(:actions, html:true) do |record|
    render 'customer_chat_supports/control', customer_chat_support: record
  end
end
