class Notification < ApplicationRecord
  TYPES = ['SubmittedReceipt']

  belongs_to :notifyable, polymorphic: true
  belongs_to :objectable, polymorphic: true

  validates :text,              presence: true
  validates :notification_type, presence: true
  validates :notification_type, inclusion: { TYPES }
end
