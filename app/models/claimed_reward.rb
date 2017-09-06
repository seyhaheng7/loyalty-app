class ClaimedReward < ApplicationRecord
  include AASM

  aasm :column => 'status' do
    state :submitted, :initial => true
    state :rejected
    state :approved

    event :rejecting do
      transitions :from => :submitted, :to => :rejected
    end

    event :approving, after: :decrease_points do
      transitions :from => :submitted, :to => :approved
    end

  end

  belongs_to :customer
  belongs_to :managed_by, :class_name => "User", optional: true
  belongs_to :reward

  validate :customer_points

  private

  def customer_points
    if customer.current_points < reward.require_points
      errors.add(:customer_points, "Customer doesn't have enough points")
    end
  end

  def decrease_points
    customer.sub_points reward.require_points.to_i
  end

end
