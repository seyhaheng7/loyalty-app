class CustomerActiveChatSupportWorker
  include Sidekiq::Worker

  def perform(id)
    customer_chat_support = CustomerChatSupport.find id
    ActionCable.server.broadcast "customer_active_chat_support_channel", id: id, seen_at: customer_chat_support.seen_at
  end
end
