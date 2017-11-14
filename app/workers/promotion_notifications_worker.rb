class PromotionNotificationsWorker
  include Sidekiq::Worker

  def perform(promotion_id)
    promotion = Promotion.find promotion_id

    Customer.all.each do |customer|
      notification = promotion.notifications.new
      notification.notifyable = customer
      notification.notification_type = "NewPromotion"
      notification.text = "New promotion!"
      notification.save
    end

    promotion.update(sent: true)

  end
end
