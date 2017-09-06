class ChangeCustomerDefaultProviderToPhone < ActiveRecord::Migration[5.1]
  def change
    change_column :customers, :provider, :string, default: 'phone'
  end
end
