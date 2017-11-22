class StickerGroup < ApplicationRecord
  has_many :stickers

  acts_as_paranoid

  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :image, presence: true, file_geometry: {is: [128, 128]}, if: :image_changed?

end
