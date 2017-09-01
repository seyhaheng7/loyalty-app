class AddSetCurrentPointsDefaultValueToUsers < ActiveRecord::Migration[5.1]
  def up
    change_column :users, :current_points, :integer, default: 0
  end

  def down
    change_column :users, :current_points, :integer, default: nil
  end
end
