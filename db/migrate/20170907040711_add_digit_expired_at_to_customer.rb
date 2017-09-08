class AddDigitExpiredAtToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :digit_expired_at, :datetime
    add_index :customers, :digit_expired_at
  end
end
