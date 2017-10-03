class Promotion < ApplicationRecord
  acts_as_paranoid

  mount_uploader :image, PromotionUploader

  validates :title, presence: true

  scope :active, -> {where(":today >= start_date AND :today <= end_date", today: Date.today)}
end
