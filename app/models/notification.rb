class Notification < ApplicationRecord
  TYPES = ['SubmittedReceipt']

  belongs_to :notifyable, polymorphic: true
  belongs_to :objectable, polymorphic: true

  validates :text,              presence: true
  validates :notification_type, presence: true
  validates :notification_type, inclusion: TYPES
  
  after_create :increase_notifyable_notifications_pending


  def increase_notifyable_notifications_pending
    if notifyable_type == 'User'
      notifyable.increase_pending_notifications
    end
  end

end
