class MerchantChatSupportDatumDecorator < ApplicationDecorator
  delegate_all

  def message_class
    if supportable_type == 'User'
      "message-sent"
    else
      "message-received"
    end
  end

end
