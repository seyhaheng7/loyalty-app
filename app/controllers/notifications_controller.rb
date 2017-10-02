class NotificationsController < ApplicationController
  def top_nav
  end

  def index
    @notifications = Notification.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end
end