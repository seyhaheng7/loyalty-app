class CustomerChatSupportChannel < ApplicationCable::Channel
  def subscribed
    if admin? || customer_chat_support.customer = current_user
      stream_from "customer_chat_support_channel_#{customer_chat_support_id}"
      if admin?
        customer_chat_support.update(admin_streaming: true)
      else
        customer_chat_support.update(customer_streaming: true)
      end
    else
      unsubscribed
    end
  end

  def unsubscribed
    if admin?
      customer_chat_support.update(admin_streaming: false)
    else
      customer_chat_support.update(customer_streaming: false)
    end
  end

  def speak(data)
    supportable = current_user
    chat_datum = supportable.customer_chat_support_data.create!(text: data["text"], customer_chat_support_id: customer_chat_support_id)
  end

  private

  def admin?
    current_user.class == User
  end

  def customer_chat_support
    @customer_chat_support ||=  if params[:room_id].present?
                                  CustomerChatSupport.find params[:room_id]
                                else
                                  current_user.customer_chat_support
                                end
  end

  def customer_chat_support_id
    if params[:room_id].present?
      params[:room_id]
    else
      customer_chat_support.id
    end
  end
end
