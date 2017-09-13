class RemoveNameFromCustomer < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :name, :string
  end
end
