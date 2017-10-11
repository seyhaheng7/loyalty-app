class AddDescriptionToReward < ActiveRecord::Migration[5.1]
  def change
    add_column :rewards, :description, :text
  end
end
