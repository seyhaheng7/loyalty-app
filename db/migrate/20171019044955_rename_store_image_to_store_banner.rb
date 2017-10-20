class RenameStoreImageToStoreBanner < ActiveRecord::Migration[5.1]
  def change
    rename_table :store_images, :store_banners
  end
end
