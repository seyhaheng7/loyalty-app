class Promotion < ApplicationRecord
  acts_as_paranoid

  mount_uploader :image, PromotionUploader

  validates :title, presence: true
  validate :end_date_after_start_date?

  default_scope { order(created_at: :desc) }
  scope :active, -> {where(":today >= start_date AND :today <= end_date", today: Date.today)}

  has_many :notifications, as: :objectable, dependent: :destroy

  scope :title_like, ->(title){ where("#{table_name}.title ilike ?", "%#{title}%") }
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

  scope :daily_push_condition, ->{where(start_date: Date.today, sent: false)}

  def self.push_daily_promotion
    Promotion.daily_push_condition.each do |promotion|
      PromotionNotificationsWorker.perform_async(promotion.id)
    end
  end

  private

    def end_date_after_start_date?
      if end_date.present? and start_date.present?
        errors.add :end_date, "must be after start date" if end_date < start_date
      end
    end

end
