class Sticker < ApplicationRecord
  belongs_to :sticker_group

  validates :name, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader

  delegate :name, to: :sticker_group, prefix: true, allow_nil: true
end
