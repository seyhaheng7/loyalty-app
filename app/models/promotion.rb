class Promotion < ApplicationRecord
  acts_as_paranoid

  mount_uploader :image, PromotionUploader

  validates :title, presence: true
end
