class ChangeColumnYoutubeUrlToVideoFile < ActiveRecord::Migration[5.1]
  def change
    if column_exists?(:video_ads, :youtube_url)
      rename_column :video_ads, :youtube_url, :video_file
    end
  end
end
