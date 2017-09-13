class ClaimedRewardPolicy < ApplicationPolicy

  def index?
    user.approver? || user.receptionist? || user.admin? || user.super?
  end

  def show?
    user.approver? || user.receptionist? || user.admin? || user.super?
  end

  def approve?
    record.submitted? and ( user.approver? || user.admin? || user.super? )
  end

  def reject?
    approve?
  end
end
