class VideoAd < ApplicationRecord
  acts_as_paranoid
  validates :title, presence: true

  mount_uploader :video_file, VideoAdUploader
  
  has_many :view_video_ads, dependent: :destroy
  scope :active, -> {where(":today >= start_date AND :today <= end_date", today: Date.today)}

end
