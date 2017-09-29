class AddGivenToClaimedReward < ActiveRecord::Migration[5.1]
  def change
    add_column :claimed_rewards, :given, :boolean, default: false
  end
end
