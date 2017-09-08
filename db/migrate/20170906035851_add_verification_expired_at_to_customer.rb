class AddVerificationExpiredAtToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :verification_expired_at, :datetime
  end
end
