class MerchantChatSupportChannel < ApplicationCable::Channel
  def subscribed
    merchant_chat_support = MerchantChatSupport.find params[:room_id]
    if current_user.admin? || merchant_chat_support.merchant == current_user
      stream_from "merchant_chat_support_channel_#{params[:room_id]}"
    else
      unsubscribed
    end
  end

  def unsubscribed
  end

  def speak(data)
    supportable = current_user
    supportable.merchant_chat_support_data.create!(text: data["text"], merchant_chat_support_id: data["merchant_chat_support_id"])
  end

end
