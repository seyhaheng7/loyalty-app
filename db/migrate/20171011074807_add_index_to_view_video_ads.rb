class AddIndexToViewVideoAds < ActiveRecord::Migration[5.1]
  def change
    add_index :view_video_ads, :view_count
  end
end
