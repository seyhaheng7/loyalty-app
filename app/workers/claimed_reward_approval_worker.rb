class ClaimedRewardApprovalWorker
  include Sidekiq::Worker

  def perform(claimed_reward_id, status)
    ActionCable.server.broadcast "claimed_reward_approval_channel", id: claimed_reward_id, status: status
  end

end