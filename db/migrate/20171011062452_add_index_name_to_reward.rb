class AddIndexNameToReward < ActiveRecord::Migration[5.1]
  def change
    add_index :rewards, :name
    add_index :rewards, [:quantity, :approved_claimed_rewards_count]
  end
end
