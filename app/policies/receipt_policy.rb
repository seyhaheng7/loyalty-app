class ReceiptPolicy < ApplicationPolicy

  def index?
    user.approver? || user.admin?
  end

  def show?
    user.approver? || user.admin?
  end

  def approve?
    record.submitted? and ( user.approver?|| user.admin? )
  end

  def reject?
    approve?
  end

  def create?
    # disable create feature
    false
  end

  def destroy?
    # disable delete feature
    false
  end

  def update?
    # disable edit feature
    false
  end
end
