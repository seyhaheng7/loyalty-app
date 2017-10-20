class RemoveStoreAndStoreBannerReference < ActiveRecord::Migration[5.1]
  def change
    remove_reference(:store_banners, :imageable, polymorphic: true)
  end
end
