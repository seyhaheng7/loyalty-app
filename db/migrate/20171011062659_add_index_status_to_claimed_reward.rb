class AddIndexStatusToClaimedReward < ActiveRecord::Migration[5.1]
  def change
    add_index :claimed_rewards, :status
    add_index :claimed_rewards, :given
  end
end
