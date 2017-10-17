class StickerGroup < ApplicationRecord
  has_many :stickers

  acts_as_paranoid
  
  validates :name, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader
end
