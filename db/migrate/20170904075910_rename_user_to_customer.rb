class RenameUserToCustomer < ActiveRecord::Migration[5.1]
  def change
    rename_table :users, :customers
    rename_column :receipts, :user_id, :customer_id
    remove_column :customers, :role
  end
end
