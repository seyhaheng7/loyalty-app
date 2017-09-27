class ReceiptPolicy < ApplicationPolicy

  def index?
    user.approver? || user.receptionist? || user.admin? || user.super?
  end

  def show?
    user.approver? || user.receptionist? || user.admin? || user.super?
  end

  def approve?
    record.submitted? and ( user.approver?|| user.admin? || user.super? )
  end

  def reject?
    approve?
  end

  # def create?
  #   # disable create feature
  #   false
  # end

  def destroy?
    # disable delete feature
    false
  end

  def update?
    # disable edit feature
    false
  end
end
