class AddIndexToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_index :customers, [:first_name, :last_name]
    add_index :customers, [:lat, :long]
    add_index :customers, :verification_expired_at
    add_index :customers, :verified_at
    add_index :customers, :update_location_at

  end
end
