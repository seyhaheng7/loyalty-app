class ClaimedReward < ApplicationRecord
  belongs_to :user
  belongs_to :reward

  validate :user_points

  private 

  def user_points
    if user.current_points < reward.require_points
      errors.add(:user_points, "User doesn't have enough points")
    end
  end

end
