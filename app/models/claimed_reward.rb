class ClaimedReward < ApplicationRecord
  has_many :notifications, as: :objectable, dependent: :destroy

  belongs_to :customer
  belongs_to :managed_by, :class_name => "User", optional: true
  belongs_to :reward, counter_cache: true

  validate :customer_points
  validate :reward_available, on: :create

  delegate :store, :store_location, to: :reward, allow_nil: true
  delegate :name, to: :customer, prefix: true, allow_nil: true
  delegate :name, to: :reward, prefix: true, allow_nil: true
  delegate :claimed_rewards, to: :store, prefix: true, allow_nil: true

  after_create :decrease_customer_points
  after_create :create_claimed_reward_success_notifications
  after_commit :create_given_claimed_reward_notifications, if: ->{ saved_change_to_given? && given? }
  before_create :generate_qr_token

  def self.filter(params)
    records = all

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

  default_scope { order(created_at: :desc) }

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

  def decrease_customer_points
    customer.sub_points reward.require_points.to_i
  end

  def generate_qr_token
    self.qr_token = Devise.friendly_token(20)
  end

  def create_claimed_reward_success_notifications
    ClaimedRewardSuccessNotificationsWorker.perform_in(2.seconds, id)
  end

  def create_given_claimed_reward_notifications
    GivenClaimedRewardNotificationsWorker.perform_async(id)
  end

end
