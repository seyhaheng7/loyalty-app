class CustomerChatSupportChannel < ApplicationCable::Channel
  def subscribed
    customer_chat_support = CustomerChatSupport.find params[:room_id]
    if current_user.admin? || customer_chat_support.customer == current_user
      stream_from "customer_chat_support_channel_#{params[:room_id]}"
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
