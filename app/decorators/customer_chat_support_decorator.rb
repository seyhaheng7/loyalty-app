class CustomerChatSupportDecorator < ApplicationDecorator
  delegate_all

  def last_message
    if customer_chat_support_data.present?
      "Last Message : " + customer_chat_support_data.last.text
    else
      nil
    end
  end

  def apply_class_chat_btn
    if seen_at.present?
      "btn btn-primary chat-btn"
    else
      "btn btn-danger chat-btn"
    end
  end

end
