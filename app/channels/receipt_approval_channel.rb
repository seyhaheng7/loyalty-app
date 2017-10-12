class ReceiptApprovalChannel < ApplicationCable::Channel
  def subscribed
    stream_from "receipt_approval_channel"
  end

  def unsubscribed
    
  end

end
