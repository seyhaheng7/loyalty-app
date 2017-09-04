class Reward < ApplicationRecord
  belongs_to :company, optional: true

  validates :name, presence: true
  validates :require_points, presence: true
  validates :quantity, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader

end
