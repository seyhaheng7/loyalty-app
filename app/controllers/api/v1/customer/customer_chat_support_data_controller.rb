module Api::V1::Customer
  class CustomerChatSupportDataController < BaseController
    swagger_controller :customer_chat_support_data, 'CustomerChatSupportData'

    swagger_api :index do
      summary 'Fetches all customer chat support data'
      param :path, :customer_chat_support_id, :integer, :required, "ID of customer chat support"
      param :query, :page, :integer, :optional, "Page number"
      response :unauthorized
      response :success
      response :not_acceptable, "The request you made is not acceptable"
      response :requested_range_not_satisfiable
    end

    def index
      customer_chat_support = current_customer.customer_chat_support
      @customer_chat_support_data = customer_chat_support.customer_chat_support_data.page(params[:page])
      render json: @customer_chat_support_data
    end

  end
end
