class CustomerChatCustomerChannel < ApplicationCable::Channel

  def subscribed
    if chat_room.customers.ids.include? current_user.try(:id)
      stream_from "customer_chat_customer_channel_#{params[:chat_room_id]}"
      chat_room.chat_members.where(customer: current_user).update(streaming: true)
    else
      unsubscribed
    end
  end

  def unsubscribed
    chat_room.chat_members.where(customer: current_user).update(streaming: false)
  end

  def speak(data)
    text = data["text"]
    sticker = data["sticker"]
    audio = data["audio"]
    chat_room_id = params[:chat_room_id]
    current_user.chat_data.create!(text: text, sticker: sticker, audio: audio, chat_room_id: chat_room_id)
  end

  private

  def chat_room
    @chat_room ||= ChatRoom.find(params[:chat_room_id])
  end

end
