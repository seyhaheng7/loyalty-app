class RemovePointRateFromCompany < ActiveRecord::Migration[5.1]
  def change
    remove_column :companies, :point_rate, :integer
  end
end
