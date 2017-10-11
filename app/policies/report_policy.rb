class ReportPolicy < ApplicationPolicy
  def rewards?
    user.admin? || user.super?
  end
end

