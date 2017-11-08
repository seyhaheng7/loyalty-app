class GivenClaimedRewardNotificationsWorker
  include Sidekiq::Worker

  def perform(claimed_reward_id)
    claimed_reward = ClaimedReward.find claimed_reward_id
    customer       = claimed_reward.customer

    notification   = claimed_reward.notifications.new
    notification.notifyable = customer
    notification.notification_type = "GivenClaimedReward"
    notification.text = "Your claimed reward  was given!"
    notification.save

    merchants      = claimed_reward.store.merchants

    merchants.each do |merchant|
      notification   = claimed_reward.notifications.new
      notification.notifyable = merchant
      notification.notification_type = "GivenClaimedReward"
      notification.text = "claimed reward  was given!"
      notification.save
    end
  end
end
