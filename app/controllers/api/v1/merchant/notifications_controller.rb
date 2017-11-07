module Api::V1::Merchant
  class NotificationsController < BaseController

    swagger_controller :notifications, 'Notifications'

    swagger_api :index do
      summary 'Fetches all notifications'
      param :query, :page, :integer, :optional, "Page number"
      response :unauthorized
      response :not_acceptable
    end

    def index
      @notifications = current_merchant.notifications.page(params[:page])
      render json: @notifications, status: :ok
    end
  end
end
