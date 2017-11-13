class ClaimedReward < ApplicationRecord
  include AASM

  aasm :column => 'status' do
    state :submitted, :initial => true
    state :rejected
    state :approved

    event :rejecting do
      transitions :from => :submitted, :to => :rejected

      after do
        create_rejected_claimed_reward_notifications
        broadcast_claimed_reward_status
      end
    end

    event :approving do
      transitions :from => :submitted, :to => :approved

      after do
        decrease_points
        generate_qr_token
        create_approved_claimed_reward_notifications
        broadcast_claimed_reward_status
      end

      before do
        set_expired_date
      end
    end

  end

  has_many :notifications, as: :objectable

  belongs_to :customer
  belongs_to :managed_by, :class_name => "User", optional: true
  belongs_to :reward, :counter_cache => :approved_claimed_rewards_count

  validate :customer_points
  validate :reward_available, on: :create

  delegate :store, :store_location, to: :reward, allow_nil: true
  delegate :name, to: :customer, prefix: true, allow_nil: true
  delegate :name, to: :reward, prefix: true, allow_nil: true
  delegate :claimed_rewards, to: :store, prefix: true, allow_nil: true

  def self.filter(params)
    records = all

    if params[:status].present?
      records = records.where(status: params[:status])
    end

    if params[:given].present?
      given = params[:given] == '1' || params[:given] == 'true'
      records = records.where(given: given)
    end

    records
  end

  scope :given, -> { where(given: true) }
  scope :not_give, -> { where(given: false) }
  scope :customer_name_like, ->(value){ joins(:customer).merge(Customer.name_like(value)) }
  scope :reward_name_like, ->(value){ joins(:reward).merge(Reward.name_like(value)) }


  after_create :create_submitted_claimed_reward_notifications
  after_commit :create_given_claimed_reward_notifications, if: ->{ saved_change_to_given? && given? }

  def broadcast_claimed_reward_status(id, status)
    ClaimedRewardApprovalWorker.perform_async(id, status)
  end

  def set_expired_date
    self.expired_at = Date.today + reward.claimed_reward_expired.to_i
  end

  def expired?
    return false if expired_at.blank?
    expired_at > Date.today
  end

  def self.notify_expired
    NotifyExpiredClaimedReward.perform_async
  end

  private

  def customer_points
    if customer.current_points < reward.require_points
      errors.add(:customer_points, "Customer doesn't have enough points")
    end
  end

  def reward_available
    errors.add(:reward, 'not available in stock') if reward.unavailable?
  end

  def decrease_points
    customer.sub_points reward.require_points.to_i
  end

  def generate_qr_token
    update(qr_token: Devise.friendly_token(20))
  end

  def create_submitted_claimed_reward_notifications
    SubmittedClaimedRewardNotificationsWorker.perform_in(2.seconds, id)
  end

  def create_approved_claimed_reward_notifications
    ApprovedClaimedRewardNotificationsWorker.perform_async(id)
  end

  def create_rejected_claimed_reward_notifications
    RejectedClaimedRewardNotificationsWorker.perform_async(id)
  end

  def broadcast_claimed_reward_status
    ClaimedRewardApprovalWorker.perform_async(self.id, self.status)
  end

  def create_given_claimed_reward_notifications
    GivenClaimedRewardNotificationsWorker.perform_async(id)
  end

end
