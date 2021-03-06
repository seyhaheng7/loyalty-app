class Reward < ApplicationRecord
  acts_as_paranoid

  belongs_to :store

  has_many :claimed_rewards, dependent: :destroy

  validates :require_points, presence: true
  validates :quantity, presence: true
  validates :image, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :name, presence: true, uniqueness: {scope: :store_id}

  mount_uploader :image, ImageUploader

  delegate :name, :location, to: :store, prefix: true, allow_nil: true

  default_scope { order(created_at: :desc) }
  scope :available, -> { where("quantity > claimed_rewards_count") }
  scope :unavailable, -> { where("quantity <= claimed_rewards_count") }
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

  # scope :start_between, ->(start_date, end_date){ where(start_date: start_date.beginning_of_day..end_date.end_of_day) }
  # scope :end_between, ->(start_date, end_date){ where(end_date: start_date.beginning_of_day..end_date.end_of_day) }
  # scope :active_between, ->(start_date, end_date){ start_between(start_date, end_date).or(end_between(start_date, end_date)) }

  def self.start_between(start_date, end_date)
    if start_date.present? and end_date.present?
      where(start_date: start_date.beginning_of_day..end_date.end_of_day)
    elsif start_date.present?
      where('start_date > ?', start_date)
    elsif end_date.present?
      where('start_date < ?', end_date)
    end
  end

  def self.end_between(start_date, end_date)
    if start_date.present? and end_date.present?
      where(end_date: start_date.beginning_of_day..end_date.end_of_day)
    elsif start_date.present?
      where('end_date > ?', start_date)
    elsif end_date.present?
      where('end_date < ?', end_date)
    end
  end

  def self.active_between(start_date, end_date)
    start_between(start_date, end_date).or(end_between(start_date, end_date))
  end

  scope :active, -> {where(":today >= start_date AND :today <= end_date", today: Date.today)}

  def available?
    quantity > claimed_rewards_count
  end

  def unavailable?
    !available?
  end

  def quantity_remain
    quantity - claimed_rewards.given.count.to_i
  end

  validate :end_date_after_start_date?

  def end_date_after_start_date?
    if end_date.present? and start_date.present?
      errors.add :end_date, "must be after start date" if end_date < start_date
    end
  end

end
