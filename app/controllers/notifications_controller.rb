class NotificationsController < ApplicationController
  def top_nav
    current_user.reset_pending_notifications
  end

  def index
    @notifications = Notification.page(params[:page])
    current_user.reset_pending_notifications
    respond_to do |format|
      format.html
      format.js
    end
  end
end
