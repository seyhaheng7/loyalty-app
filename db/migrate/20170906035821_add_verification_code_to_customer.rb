class AddVerificationCodeToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :verification_code, :string
  end
end
