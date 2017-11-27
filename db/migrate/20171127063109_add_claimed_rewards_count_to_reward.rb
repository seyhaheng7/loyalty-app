class AddClaimedRewardsCountToReward < ActiveRecord::Migration[5.1]
  def change
    rename_column :rewards, :approved_claimed_rewards_count, :claimed_rewards_count
  end
end
