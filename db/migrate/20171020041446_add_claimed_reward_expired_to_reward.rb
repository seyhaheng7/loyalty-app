class AddClaimedRewardExpiredToReward < ActiveRecord::Migration[5.1]
  def change
    add_column :rewards, :claimed_reward_expired, :integer
  end
end
