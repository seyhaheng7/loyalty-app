class AddExpiredAtAndIsExpiredToClaimedReward < ActiveRecord::Migration[5.1]
  def change
    add_column :claimed_rewards, :expired_at, :date
  end
end
