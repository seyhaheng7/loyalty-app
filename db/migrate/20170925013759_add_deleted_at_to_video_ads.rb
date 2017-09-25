class AddDeletedAtToVideoAds < ActiveRecord::Migration[5.1]
  def change
    add_column :video_ads, :deleted_at, :datetime
    add_index :video_ads, :deleted_at
  end
end
