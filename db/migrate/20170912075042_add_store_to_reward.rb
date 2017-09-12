class AddStoreToReward < ActiveRecord::Migration[5.1]
  def change
    add_reference :rewards, :store, foreign_key: true
  end
end
