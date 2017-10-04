class CustomerChatCustomerChannel < ApplicationCable::Channel

  def subscribed
    stream_from "customer_chat_customer_channel_#{params[:chat_room_id]}"
  end

  def unsubscribed
  end

  def speak(data)
    text = data["text"]
    chat_room_id = params[:chat_room_id]
    current_user.chat_data.create!(text: text, chat_room_id: chat_room_id)
  end

end
