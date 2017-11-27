class Advertisement < ApplicationRecord
  acts_as_paranoid

  validates :name, presence: true
  validates :banner, presence:true
  validate :end_date_after_start_date?

  PAGES = ['Home', 'Watch & Earn', 'Category detail', 'Rewards', 'Snap']
  validates :for_page, inclusion: PAGES, presence:true

  scope :name_like, ->(name){ where("#{table_name}.name ilike ?", "%#{name}%") }
  scope :address_like, ->(address){ where("#{table_name}.address ilike ?", "%#{address}%") }

  mount_uploader :banner, BannerUploader

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

  def self.filter(params)
    records = all

    if params[:for_page].present?
      records = records.where(for_page: params[:for_page])
    end

    records
  end

  default_scope { order(created_at: :desc) }
  scope :active, -> {where(":today >= start_date AND :today <= end_date", today: Date.today)}
  scope :for_page, ->(page){where(for_page: page)}

  has_many :banners, dependent: :destroy
  accepts_nested_attributes_for :banners, allow_destroy: true,  reject_if: :all_blank

  private

  def end_date_after_start_date?
    if end_date.present? and start_date.present?
      errors.add :end_date, "must be after start date" if end_date < start_date
    end
  end

end