class ClaimedReward < ApplicationRecord
  include AASM

  # before_validation do
  #   binding.pry
  # end

  aasm :column => 'status' do
    state :submitted, :initial => true
    state :rejected
    state :approved

    event :rejecting do
      transitions :from => :submitted, :to => :rejected
    end

    event :approving, after: [:decrease_points, :generate_qr_token] do
      transitions :from => :submitted, :to => :approved
    end

  end

  belongs_to :customer
  belongs_to :managed_by, :class_name => "User", optional: true
  belongs_to :reward, :counter_cache => :approved_claimed_rewards_count

  validate :customer_points
  validate :reward_available, on: :create

  delegate :name, to: :customer, prefix: true, allow_nil: true
  delegate :name, to: :reward, prefix: true, allow_nil: true


  def self.filter(params)
    records = all

    if params[:status].present?
      records = records.where(status: params[:status])
    end

    records
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

end
