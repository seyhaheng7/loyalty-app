class Notification < ApplicationRecord
  TYPES = ['SubmittedReceipt']

  belongs_to :notifyable, polymorphic: true
  belongs_to :objectable, polymorphic: true

  validates :text,              presence: true
  validates :notification_type, presence: true
  validates :notification_type, inclusion: TYPES
  
  #only create
  after_create :increase_notifyable_notifications_pending
  #work after commit when create
  after_commit :broadcast_notification_increment, on: :create
  after_commit :push_notification, on: :create

  private

  def increase_notifyable_notifications_pending
    if notifyable_type == 'User'
      notifyable.increase_pending_notifications
    end
  end

  def broadcast_notification_increment
    NotificationsWorker.perform_async(id)
  end

  def push_notification
    PushNotificationWorker.perform_async
  end

end
