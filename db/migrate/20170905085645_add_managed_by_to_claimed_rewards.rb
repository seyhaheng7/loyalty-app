class AddManagedByToClaimedRewards < ActiveRecord::Migration[5.1]
  def change
    add_reference :claimed_rewards, :managed_by, references: :users
  end
end
