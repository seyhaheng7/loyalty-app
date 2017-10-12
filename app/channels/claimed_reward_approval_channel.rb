class ClaimedRewardApprovalChannel < ApplicationCable::Channel
  def subscribed
    stream_from "claimed_reward_approval_channel"
  end

  def unsubscribed
    
  end

end
