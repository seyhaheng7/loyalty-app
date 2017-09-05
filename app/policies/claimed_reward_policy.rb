class ClaimedRewardPolicy < ApplicationPolicy
  def approve?
    record.submitted? and ( user.admin? || user.super? )
  end

  def reject?
    approve?
  end
end
