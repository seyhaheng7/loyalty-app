class Promotion < ApplicationRecord
  acts_as_paranoid

  mount_uploader :image, PromotionUploader

  validates :title, presence: true

  default_scope { order(created_at: :desc) }
  scope :active, -> {where(":today >= start_date AND :today <= end_date", today: Date.today)}

  has_many :notifications, as: :objectable

  # after_commit :create_promotion_notification

  # private

  # def create_promotion_notification
  #   PromotionNotificationsWorker.perform_async(id)
  # end
  #

  scope :daily_push_condition, ->{where(start_date: Date.today, sent: false)}

  def self.push_daily_promotion
    Promotion.daily_push_condition.each do |promotion|
      PromotionNotificationsWorker.perform_async(promotion.id)
    end
  end

end
