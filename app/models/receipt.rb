class Receipt < ApplicationRecord
  include AASM

  aasm :column => 'status' do
    state :submitted, :initial => true
    state :rejected
    state :approved

    event :rejecting, after: [:create_rejected_notifications, :broadcast_receipt_status] do
      transitions :from => :submitted, :to => :rejected
    end

    event :approving, after: [:add_points_to_user, :create_approved_notifications, :broadcast_receipt_status] do
      transitions :from => :submitted, :to => :approved
    end
  end

  acts_as_paranoid

  belongs_to :store
  belongs_to :customer
  belongs_to :managed_by, :class_name => "User", optional: true

  has_many :notifications, as: :objectable
  mount_base64_uploader :capture, ImageUploader

  validates :receipt_id, presence: true
  validates :total, presence: true
  # validates :capture, presence: true
  validates :receipt_id, :uniqueness => {:scope => :store_id, message: "Receipt is already submitted"}

  after_create :create_notifications

  delegate :name, to: :store, prefix: true, allow_nil: true
  delegate :name, to: :customer, prefix: true, allow_nil: true

  def new_store=(params)
    new_store = Store.new params
    new_store.save(validate: false)
    self.store = new_store
  end

  def calculate_earned_points
    self.earned_points = total.to_i / Setting.rating.to_i
  end

  private

  def add_points_to_user
    customer.add_points earned_points.to_i
  end

  def create_notifications
    SubmittedReceiptNotificationsWorker.perform_async(id)
  end

  def create_rejected_notifications
    RejectReceiptNotificationsWorker.perform_async(id)
  end

  def create_approved_notifications
    ApprovedReceiptNotificationsWorker.perform_async(id)
  end

  def broadcast_receipt_status
    ReceiptApprovalWorker.perform_async(self.id, self.status)
  end

end
