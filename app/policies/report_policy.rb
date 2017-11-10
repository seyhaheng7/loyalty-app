class ReportPolicy < ApplicationPolicy
  def rewards?
    user.admin? || user.super?
  end

  def video_ads?
    user.admin? || user.super?
  end

  def ads?
    user.admin?
  end

end

