class ChangeVideoAdColumnVideoToYoutubeUrl < ActiveRecord::Migration[5.1]
  def change
    rename_column :video_ads, :video, :youtube_url
  end
end
