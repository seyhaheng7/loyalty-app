class MerchantChatSupportChannel < ApplicationCable::Channel
  def subscribed
    if admin? || merchant_chat_support.merchant == current_user
      stream_from "merchant_chat_support_channel_#{merchant_chat_support_id}"
      if admin?
        merchant_chat_support.update(admin_streaming: true)
      else
        merchant_chat_support.update(merchant_streaming: true)
      end
    else
      unsubscribed
    end
  end

  def unsubscribed
    if admin?
      merchant_chat_support.update(admin_streaming: false)
    else
      merchant_chat_support.update(merchant_streaming: false)
    end
  end

  def speak(data)
    supportable = current_user
    supportable.merchant_chat_support_data.create!(text: data["text"], merchant_chat_support_id: merchant_chat_support_id)
  end


  private

  def admin?
    current_user.class == User
  end


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
