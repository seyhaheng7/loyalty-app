class VideoAd < ApplicationRecord
  acts_as_paranoid
  validates :title, presence: true

  mount_uploader :video_file, VideoAdUploader
  mount_uploader :thumbnail, ImageUploader
  
  has_many :view_video_ads, dependent: :destroy
  scope :active, -> {where(":today >= start_date AND :today <= end_date", today: Date.today)}

end
