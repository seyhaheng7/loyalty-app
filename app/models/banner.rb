class Banner < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :advertisement

  validates :image, presence: true, file_geometry: {is: [700, 300]}, if: :image_changed?

end
