class AddIndexToVideoAds < ActiveRecord::Migration[5.1]
  def change
    add_index :video_ads, :max_view_per_day
  end
end
