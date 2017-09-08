class AddLoginDigitToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :login_digit, :string
    add_index :customers, :login_digit
  end
end
