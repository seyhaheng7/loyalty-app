class ChangeClaimedRewardUserToCustomer < ActiveRecord::Migration[5.1]
  def change
    rename_column :claimed_rewards, :user_id, :customer_id
  end
end
