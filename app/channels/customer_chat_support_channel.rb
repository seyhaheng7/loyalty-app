class CustomerChatSupportChannel < ApplicationCable::Channel
  def subscribed
    customer_chat_support = current_user.customer_chat_support
    if current_user.admin? || customer_chat_support.present?
      stream_from "customer_chat_support_channel_#{customer_chat_support.id}"
    else
      unsubscribed
    end
  end

  def unsubscribed
  end

  def speak(data)
    supportable = current_user
    supportable.customer_chat_support_data.create!(text: data["text"], customer_chat_support_id: data["customer_chat_support_id"])
  end
end
