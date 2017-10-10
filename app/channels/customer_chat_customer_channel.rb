class CustomerChatCustomerChannel < ApplicationCable::Channel

  def subscribed
    chat_room = ChatRoom.find params[:chat_room_id]
    if chat_room.customers.ids.includes? current_user.try(:id)
      stream_from "customer_chat_customer_channel_#{params[:chat_room_id]}"
    else
      unsubscribed
    end
  end

  def unsubscribed
  end

  def speak(data)
    text = data["text"]
    sticker = data["sticker"]
    chat_room_id = params[:chat_room_id]
    current_user.chat_data.create!(text: text, sticker: sticker, chat_room_id: chat_room_id)
  end

end
