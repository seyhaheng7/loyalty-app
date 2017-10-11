class CustomerChatSupportWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'chat'
  
  def perform(chat_datum_id)
    chat_datum = CustomerChatSupportDatum.find chat_datum_id
    ActionCable.server.broadcast "customer_chat_support_channel_#{chat_datum.customer_chat_support.id}", chat_datum: chat_datum
  end
end
