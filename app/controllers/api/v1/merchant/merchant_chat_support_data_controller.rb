module Api::V1::Merchant
  class MerchantChatSupportDataController < BaseController
    swagger_controller :merchant_chat_support_data, 'MerchantChatSupportData'

    swagger_api :index do
      summary 'Fetches all merchant chat support data'
      param :path, :merchant_chat_support_id, :integer, :required, "ID of merchant chat support"
      param :query, :page, :integer, :optional, "Page number"
      response :unauthorized
      response :success
      response :not_acceptable, "The request you made is not acceptable"
      response :requested_range_not_satisfiable
    end


    swagger_api :create do |api|
      summary 'Create merchant chat support data'
      notes "(Channel: MerchantChatSupportChannel) (Notification: MerchantChatSupport)"
      api.param :form, 'data[text]', :string, :required, 'Text'
      response :unauthorized
      response :success
      response :not_acceptable, "The request you made is not acceptable"
    end

    def index
      merchant_chat_support = current_merchant.merchant_chat_support
      @merchant_chat_support_data = merchant_chat_support.merchant_chat_support_data.order(id: :desc).page(params[:page])
      render json: @merchant_chat_support_data
    end


    def create
      merchant_chat_support = current_merchant.merchant_chat_support
      chat_datum = current_merchant.merchant_chat_support_data.new(data_params.merge(merchant_chat_support: merchant_chat_support))
      if chat_datum.save
        render json: chat_datum, status: :created
      else
        render json: chat_datum.errors, status: :unprocessable_entity
      end
    end


    private

    def data_params
      params.require(:data).permit(:text)
    end

  end
end
