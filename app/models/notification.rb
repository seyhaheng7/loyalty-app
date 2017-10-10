class Notification < ApplicationRecord
  TYPES = ['SubmittedReceipt', 'RejectedReceipt', 'ApprovedReceipt', 'SubmittedClaimedReward', 'ApprovedClaimedReward', 'RejectedClaimedReward']


  belongs_to :notifyable, polymorphic: true
  belongs_to :objectable, polymorphic: true

  validates :text,              presence: true
  validates :notification_type, presence: true
  validates :notification_type, inclusion: TYPES

  #only create
  after_create :increase_notifyable_notifications_pending
  #work after commit when create
  after_commit :push_notification, on: :create

  default_scope { order(created_at: :desc) }

  private

  def increase_notifyable_notifications_pending
    if notifyable_type == 'User'
      notifyable.increase_pending_notifications
    end
  end

  def push_notification
    sleep 1
    PushNotificationWorker.perform_async(id)
  end

end
