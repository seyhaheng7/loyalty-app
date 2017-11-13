class NotifyExpiredClaimedReward
  include Sidekiq::Worker


  def perform
    ClaimedReward.not_give.where(expired_at: Time.now.beginning_of_day..Time.now.end_of_day).each do |claimed_reward|
      notify_customer(claimed_reward)
      notify_merchants(claimed_reward)
    end
  end


  def notify_customer(claimed_reward)
    notification = claimed_reward.notifications.new
    notification.notifyable = claimed_reward.customer
    notification.notification_type = "ClaimedRewardExpired"
    notification.text = "Your claimed reward  was expired!"
    notification.save
  end

  def notify_merchants(claimed_reward)
    claimed_reward.store.merchants.each do |merchant|
      notification = claimed_reward.notifications.new
      notification.notifyable = merchant
      notification.notification_type = "ClaimedRewardExpired"
      notification.text = "Claimed reward  was expired!"
      notification.save
    end
  end

end
