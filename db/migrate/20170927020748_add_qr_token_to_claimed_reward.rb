class AddQrTokenToClaimedReward < ActiveRecord::Migration[5.1]
  def change
    add_column :claimed_rewards, :qr_token, :string
  end
end
