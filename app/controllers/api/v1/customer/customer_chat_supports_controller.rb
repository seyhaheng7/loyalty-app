module Api::V1::Customer
  class CustomerChatSupportsController < BaseController
    swagger_controller :customer_chat_supports, 'CustomerChatSupports'

    swagger_api :index do
      summary 'Fetches all customer chat support'
      response :unauthorized
      response :not_acceptable
    end

    def index
      @customer_chat_support = current_customer.customer_chat_support
      render json: @customer_chat_support
    end
  end
end
