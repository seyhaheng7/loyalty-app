class ChangeStoreImageColumnNameToImage < ActiveRecord::Migration[5.1]
  def change
    rename_column :store_images, :name, :image
  end
end
