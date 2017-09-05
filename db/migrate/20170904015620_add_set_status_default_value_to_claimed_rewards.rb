class AddSetStatusDefaultValueToClaimedRewards < ActiveRecord::Migration[5.1]
  def up
    change_column :claimed_rewards, :status, :string, default: "submitted"
  end

  def down
    change_column :claimed_rewards, :status, :string, default: nil
  end
end
