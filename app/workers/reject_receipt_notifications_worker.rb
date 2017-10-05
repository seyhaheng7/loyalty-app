class RejectReceiptNotificationsWorker
  include Sidekiq::Worker

  def perform(receipt_id)
    receipt = Receipt.find receipt_id
    customer = receipt.customer
    notification = receipt.notifications.new
    notification.notifyable = customer
    notification.notification_type = "RejectedReceipt"
    notification.text = "Your receipt was rejected!"
    notification.save
  end
end
