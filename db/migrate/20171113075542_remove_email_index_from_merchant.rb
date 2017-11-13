class RemoveEmailIndexFromMerchant < ActiveRecord::Migration[5.1]
  def change
    remove_index(:merchants, :name => 'index_merchants_on_email')
  end
end
