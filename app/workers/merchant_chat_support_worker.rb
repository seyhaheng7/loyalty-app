class MerchantChatSupportWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'chat'
  
  def perform(chat_datum_id)
    chat_datum = MerchantChatSupportDatum.find chat_datum_id
    ActionCable.server.broadcast "merchant_chat_support_channel_#{chat_datum.merchant_chat_support.id}", chat_datum: chat_datum
  end

end
