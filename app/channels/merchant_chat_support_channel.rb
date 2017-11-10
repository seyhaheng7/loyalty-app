class MerchantChatSupportChannel < ApplicationCable::Channel
  def subscribed
    if current_user.admin? || merchant_chat_support.merchant == merchant
      stream_from "merchant_chat_support_channel_#{merchant_chat_support_id}"
    else
      unsubscribed
    end
  end

  def unsubscribed
  end

  def speak(data)
    supportable = current_user
    supportable.merchant_chat_support_data.create!(text: data["text"], merchant_chat_support_id: merchant_chat_support_id)
  end


  private


  def merchant_chat_support
    current_user.merchant_chat_support
  end

  def merchant_chat_support_id
    if params[:room_id].present?
      params[:room_id]
    else
      merchant_chat_support.id
    end
  end
end
