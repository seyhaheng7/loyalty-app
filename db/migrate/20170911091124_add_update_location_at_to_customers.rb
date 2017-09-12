class AddUpdateLocationAtToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :update_location_at, :datetime
  end
end
