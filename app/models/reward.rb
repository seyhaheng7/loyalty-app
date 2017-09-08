class Reward < ApplicationRecord
  acts_as_paranoid

  belongs_to :company, optional: true
  has_many :claimed_rewards, dependent: :restrict_with_error

  validates :name, presence: true
  validates :require_points, presence: true
  validates :quantity, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader

  delegate :name, to: :company, prefix: true, allow_nil: true

end
