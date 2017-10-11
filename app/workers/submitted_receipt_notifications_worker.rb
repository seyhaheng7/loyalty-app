class SubmittedReceiptNotificationsWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'notification'

  def perform(receipt_id)
    receipt = Receipt.find receipt_id
    User.admin_or_approver.each do |user|
      notification = receipt.notifications.new
      notification.notifyable = user
      notification.notification_type = "SubmittedReceipt"
      notification.text = "New receipt was submitted!"
      notification.save
    end
  end
end
