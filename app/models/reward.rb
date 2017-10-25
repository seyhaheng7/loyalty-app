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

  delegate :name, :location, to: :store, prefix: true, allow_nil: true

  default_scope { order(created_at: :desc) }
  scope :available, -> { where("quantity > approved_claimed_rewards_count") }
  scope :unavailable, -> { where("quantity <= approved_claimed_rewards_count") }
  scope :name_like, ->(name){ where("#{table_name}.name ilike ?", "%#{name}%") }

  def self.filter(params)
    records = all

    if params[:name].present?
      records = records.name_like(params[:name])
    end

    if params[:store_name].present?
      records = records.joins(:store).merge(Store.name_like(params[:store_name]))
    end

    records
  end

  def self.order_with(params)
    records = all
    case params[:order_by]
    when 'newly added'
      records = records.reorder(created_at: :desc)
    when 'low point'
      records = records.reorder(require_points: :asc)
    when 'hight point'
      records = records.reorder(require_points: :desc)
    when 'vocher price'
      records = records.reorder(price: :desc)
    end
    records
  end

  def available?
    quantity > approved_claimed_rewards_count
  end

  def unavailable?
    !available?
  end

  def quantity_remain
    quantity - claimed_rewards.given.count.to_i
  end

end
