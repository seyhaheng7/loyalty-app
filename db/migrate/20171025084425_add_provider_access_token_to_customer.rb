class AddProviderAccessTokenToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :provider_access_token, :string
  end
end
