class StoreBanner < ApplicationRecord

  mount_uploader :image, ImageUploader
  belongs_to :store

  validates :image, presence: true, file_geometry: {is: [700, 300]}, if: :image_changed?

end
