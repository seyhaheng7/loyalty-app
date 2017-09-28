class VideoAd < ApplicationRecord
  acts_as_paranoid
  validates :title, presence: true

  mount_uploader :video, VideoAdUploader
end
