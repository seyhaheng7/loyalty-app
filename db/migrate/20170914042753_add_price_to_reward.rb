class AddPriceToReward < ActiveRecord::Migration[5.1]
  def change
    add_column :rewards, :price, :float
  end
end
