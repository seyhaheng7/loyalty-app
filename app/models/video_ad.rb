class VideoAd < ApplicationRecord
  acts_as_paranoid
  validates :title, presence: true

  has_many :view_video_ads, dependent: :destroy

  mount_uploader :video, VideoAdUploader

  scope :active, -> {where(":today >= start_date AND :today <= end_date", today: Date.today)}

  def youtube_id
    YoutubeID.from(youtube_url)
  end

  def embed_url
    url = "http://www.youtube.com/embed/#{youtube_id}"
  end

end
