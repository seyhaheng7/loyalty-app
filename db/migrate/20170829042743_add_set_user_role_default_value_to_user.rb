class AddSetUserRoleDefaultValueToUser < ActiveRecord::Migration[5.1]

  def up
    change_column :users, :role, :string, default: "Customer"
  end

  def down
    change_column :users, :role, :string, default: nil
  end
  
end
