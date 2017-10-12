class ReceiptApprovalWorker
  include Sidekiq::Worker

  def perform(receipt_id, status)
    ActionCable.server.broadcast "receipt_approval_channel", id: receipt_id, status: status
  end

end