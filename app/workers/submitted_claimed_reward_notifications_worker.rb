class SubmittedClaimedRewardNotificationsWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'notification'

  def perform(claimed_reward_id)
    claimed_reward = ClaimedReward.find claimed_reward_id
    User.admin_or_approver.each do |user|
      notification = claimed_reward.notifications.new
      notification.notifyable = user
      notification.notification_type = "SubmittedClaimedReward"
      notification.text = "New reward claim was submitted!"
      notification.save
    end
  end
end