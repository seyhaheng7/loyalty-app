class RenameOperationSystemColumnUserToCustomer < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :operating_systems, :users
    rename_column :operating_systems, :user_id, :customer_id
    add_foreign_key :operating_systems, :customers
  end
end
