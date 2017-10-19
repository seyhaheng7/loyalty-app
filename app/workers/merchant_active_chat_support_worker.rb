class MerchantActiveChatSupportWorker
  include Sidekiq::Worker

  def perform(id)
    merchant_chat_support = MerchantChatSupport.find id
    ActionCable.server.broadcast "merchant_active_chat_support_channel", id: id, seen_at: merchant_chat_support.seen_at
  end
end
