class MerchantChatSupportsGrid

  include Datagrid

  scope do
    MerchantChatSupport
  end

  filter(:merchant_id, :enum, :select => lambda {Merchant.all.map {|m| [m.name, m.id]}})


  column(:avatar, html: true) do |record|
    image_tag record.merchant_avatar, size: '50x50'
  end

  column(:merchant, html: true) do |record|
    link_to record.merchant do
      record.merchant_name
    end
  end

  column(:actions, html:true) do |record|
    render 'merchant_chat_supports/control', merchant_chat_support: record
  end

end
