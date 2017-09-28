class MerchantChatSupportsGrid

  include Datagrid

  scope do
    MerchantChatSupport
  end

  filter(:id, :integer)
  filter(:created_at, :date, :range => true)

  column(:id)

  column(:created_at) do |model|
    model.created_at.to_date
  end

  column(:actions, html:true) do |record|
    render 'merchant_chat_supports/control', merchant_chat_support: record
  end

end
