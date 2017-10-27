class AddBannerToVideoAd < ActiveRecord::Migration[5.1]
  def change
    add_column :video_ads, :banner, :string
  end
end
