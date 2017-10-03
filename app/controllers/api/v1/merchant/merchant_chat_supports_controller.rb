module Api::V1::Merchant
  class MerchantChatSupportsController < BaseController
    swagger_controller :merchant_chat_supports, 'MerchantChatSupports'

    swagger_api :index do
      summary 'Fetches all merchant chat support'
      response :unauthorized
      response :not_acceptable
    end

    def index
      @merchant_chat_support = current_merchant.merchant_chat_support
      render json: @merchant_chat_support
    end

  end
end
