class CreateClaimedRewards < ActiveRecord::Migration[5.1]
  def change
    create_table :claimed_rewards do |t|
      t.string :status
      t.references :user, foreign_key: true
      t.references :reward, foreign_key: true

      t.timestamps
    end
  end
end
