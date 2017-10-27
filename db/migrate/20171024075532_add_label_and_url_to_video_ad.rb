class AddLabelAndUrlToVideoAd < ActiveRecord::Migration[5.1]
  def change
    add_column :video_ads, :label, :string
    add_column :video_ads, :ios_url, :string
    add_column :video_ads, :android_url, :string
  end
end
