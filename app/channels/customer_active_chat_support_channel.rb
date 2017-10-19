class CustomerActiveChatSupportChannel < ApplicationCable::Channel
  def subscribed
    if current_user.admin?
      stream_from "customer_active_chat_support_channel"
    else
      unsubscribed
    end
  end

  def unsubscribed
  end

end
