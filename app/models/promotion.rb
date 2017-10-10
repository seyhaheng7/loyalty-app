class Promotion < ApplicationRecord
  acts_as_paranoid

  mount_uploader :image, PromotionUploader

  validates :title, presence: true

  scope :active, -> {where(":today >= start_date AND :today <= end_date", today: Date.today)}

  has_many :notifications, as: :objectable
  
  # after_commit :create_promotion_notification

  # private

  # def create_promotion_notification
  #   PromotionNotificationsWorker.perform_async(id)
  # end
  # 
  def push_daily_promotion
    Promotion.where(start_date: Date.today).each do |promotion|    
      PromotionNotificationsWorker.perform_async(promotion.id)
    end
  end

end
