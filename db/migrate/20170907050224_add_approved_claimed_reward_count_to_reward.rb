class AddApprovedClaimedRewardCountToReward < ActiveRecord::Migration[5.1]
  def change
    add_column :rewards, :approved_claimed_rewards_count, :integer, default: 0
  end
end
