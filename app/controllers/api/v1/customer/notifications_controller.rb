module Api::V1::Customer
  class NotificationsController < BaseController

    swagger_controller :notifications, 'Notifications'

    swagger_api :index do
      summary 'Fetches all notifications'
      response :unauthorized
      response :not_acceptable
    end

    def index
      @notifications = Notification.all
      render json: @notifications, status: :ok
    end
  end
end
