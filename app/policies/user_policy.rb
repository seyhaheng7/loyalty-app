class UserPolicy < ApplicationPolicy
  def index?
    user.admin? || user.super?
  end

  def show?
    user.admin? || user.super?
  end

  def create?
    user.admin? || user.super?
  end

  def new?
    create?
  end

  def update?
    user.admin? || user.super?
  end

  def edit?
    update?
  end

  def destroy?
    user.admin? || user.super?
  end

end
