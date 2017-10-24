class AddPriceAndViewToAdvertisement < ActiveRecord::Migration[5.1]
  def change
    add_column :advertisements, :price, :float
    add_column :advertisements, :view, :integer
  end
end
