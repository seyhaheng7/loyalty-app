class ApprovedReceiptNotificationsWorker
  include Sidekiq::Worker

  def perform(receipt_id)
    receipt = Receipt.find receipt_id
    customer = receipt.customer
    notification = receipt.notifications.new
    notification.notifyable = customer
    notification.notification_type = "ApprovedReceipt"
    notification.text = "Your receipt was approved!"
    notification.save
    
  end
end
