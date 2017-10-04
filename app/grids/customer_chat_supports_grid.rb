class CustomerChatSupportsGrid

  include Datagrid

  scope do
    CustomerChatSupport
  end

  filter(:customer_id, :enum,:select => lambda {Customer.all.map {|p| [p.name, p.id]}})

  column(:avatar, html: true) do |record|
    image_tag record.customer_avatar, size: '30x30'
  end

  column(:customer, html: true) do |record|
    link_to record.customer do
      record.customer_name
    end
  end

  column(:actions, html:true) do |record|
    render 'customer_chat_supports/control', customer_chat_support: record
  end
end
