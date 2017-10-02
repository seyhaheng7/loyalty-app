class AddMaxViewPerDayToVideoAd < ActiveRecord::Migration[5.1]
  def change
    add_column :video_ads, :max_view_per_day, :integer
  end
end
