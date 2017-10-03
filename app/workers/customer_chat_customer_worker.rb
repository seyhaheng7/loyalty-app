class CustomerChatCustomerWorker
  include Sidekiq::Worker

  def perform(chat_datum_id)
    chat_datum = ChatDatum.find chat_datum_id
    ActionCable.server.broadcast "customer_chat_customer_channel_#{chat_datum.customer.id}", chat_datum: chat_datum 
  end
end
