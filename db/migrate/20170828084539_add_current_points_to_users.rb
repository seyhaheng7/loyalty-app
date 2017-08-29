class AddCurrentPointsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_points, :integer
  end
end
