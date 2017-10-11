class AddIndexForPageToAdvertisements < ActiveRecord::Migration[5.1]
  def change
    add_index :advertisements, :for_page
  end
end
