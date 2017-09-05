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

  belongs_to :user
  belongs_to :managed_by, :class_name => "User", optional: true
  belongs_to :reward

  validate :user_points

  private 

  def user_points
    if user.current_points < reward.require_points
      errors.add(:user_points, "User doesn't have enough points")
    end
  end

  def decrease_points
    user.sub_points reward.require_points.to_i
  end

end
