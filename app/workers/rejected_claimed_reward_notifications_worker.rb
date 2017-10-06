class RejectedClaimedRewardNotificationsWorker
  include Sidekiq::Worker

  def perform(claimed_reward_id)
    claimed_reward = ClaimedReward.find claimed_reward_id
    customer = claimed_reward.customer
    notification = receipt.notifications.new
    notification.notifyable = customer
    notification.notification_type = "RejectedClaimedReward"
    notification.text = "Your reward claim was rejected!"
    notification.save
  end
end