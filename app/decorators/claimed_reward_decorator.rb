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
    if model.approved?
      '<b>Approved by</b> ' + managed_by.name
    elsif model.rejected?
      '<b>Rejected by</b> ' + managed_by.name
    else
      '<b>Sumitted</b> '
    end
  end

end
