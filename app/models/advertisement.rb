class Advertisement < ApplicationRecord
  acts_as_paranoid

  validates :name, presence: true
  validates :banner, presence:true

  PAGES = ['Home', 'Watch & Earn', 'Category detail', 'Rewards', 'Snap']
  validates :for_page, inclusion: PAGES

  mount_uploader :banner, BannerUploader

  scope :start_between, ->(start_date, end_date){ where(start_date: start_date.beginning_of_day..end_date.end_of_day) }
  scope :end_between, ->(start_date, end_date){ where(end_date: start_date.beginning_of_day..end_date.end_of_day) }
  scope :active_between, ->(start_date, end_date){ start_between(start_date, end_date).or(end_between(start_date, end_date)) }

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

end
