class Reward < ApplicationRecord
  acts_as_paranoid

  belongs_to :store, optional: true

  has_many :claimed_rewards, dependent: :restrict_with_error
  has_many :approved_claimed_rewards, -> { approved }, class_name: 'ClaimedReward'

  validates :require_points, presence: true
  validates :quantity, presence: true
  validates :image, presence: true
  validates :name, presence: true, uniqueness: {scope: :store_id}


  mount_uploader :image, ImageUploader

  delegate :name, to: :store, prefix: true, allow_nil: true

  scope :available, -> { where("quantity > approved_claimed_rewards_count") }

  
  def available?
    quantity > approved_claimed_rewards_count
  end

  def unavailable?
    !available?
  end

end
