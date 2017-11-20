class AddTermToReward < ActiveRecord::Migration[5.1]
  def change
    add_column :rewards, :term, :text
  end
end
