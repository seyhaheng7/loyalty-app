class ApprovedClaimedRewardNotificationsWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'notification'

  def perform(claimed_reward_id)
    claimed_reward = ClaimedReward.find claimed_reward_id
    customer = claimed_reward.customer
    notification = claimed_reward.notifications.new
    notification.notifyable = customer
    notification.notification_type = "ApprovedClaimedReward"
    notification.text = "Your reward claim was approved!"
    notification.save

  end
end
