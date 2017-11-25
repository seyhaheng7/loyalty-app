class ReportPolicy < ApplicationPolicy
  def rewards?
    user.admin?
  end

  def video_ads?
    user.admin?
  end

  def ads?
    user.admin?
  end

  def customer_log?
    user.admin?
  end

end

