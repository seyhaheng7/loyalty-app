class AddVerifiedAtToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :verified_at, :datetime
  end
end
