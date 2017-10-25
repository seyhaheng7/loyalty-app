class AddProviderAccessTokenToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider_access_token, :string
  end
end
