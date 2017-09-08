class ClaimedRewardDecorator < ApplicationDecorator
  delegate_all

  def manage_climed_reward
    if managed_by.present?
      managed_by_status
    else
      'Not Yet Approved or Rejected!'
    end
  end

  def managed_by_status
    if approved?
      'Approved By ' + managed_by.name
    else
      'Rejected By ' + managed_by.name
    end
  end

end