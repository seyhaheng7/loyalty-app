class ClaimedRewardSuccessNotificationsWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'notification'

  def perform(claimed_reward_id)
    claimed_reward = ClaimedReward.find claimed_reward_id
    notify_customer(claimed_reward)
    notify_merchant(claimed_reward)
  end

  def notify_customer(claimed_reward)
    customer = claimed_reward.customer
    notification = claimed_reward.notifications.new
    notification.notifyable = customer
    notification.notification_type = "ClaimedRewardSuccess"
    notification.text = "Your reward has successfully claimed!"
    notification.save
  end

  def notify_merchant(claimed_reward)
    store = claimed_reward.store
    store.merchants.each do |merchant|
      notification = claimed_reward.notifications.new
      notification.notifyable = merchant
      notification.notification_type = "ClaimedRewardSuccess"
      notification.text = "Reward claimed successfully!"
      notification.save
    end

  end
end
