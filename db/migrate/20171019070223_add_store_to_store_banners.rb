class AddStoreToStoreBanners < ActiveRecord::Migration[5.1]
  def change
    add_reference :store_banners, :store, foreign_key: true
  end
end
