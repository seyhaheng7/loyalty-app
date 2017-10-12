class AddThumbnailToVideoAds < ActiveRecord::Migration[5.1]
  def change
    add_column :video_ads, :thumbnail, :string
  end
end
