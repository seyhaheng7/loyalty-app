class StickerGroup < ApplicationRecord
  has_many :stickers
  validates :name, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader
end
