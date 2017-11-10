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


    swagger_api :create do |api|
      summary 'Create customer chat support data'

      api.param :form, 'data[text]', :string, :required, 'Text'
      response :unauthorized
      response :success
      response :not_acceptable, "The request you made is not acceptable"
    end

    def index

      customer_chat_support = current_customer.customer_chat_support
      @customer_chat_support_data = customer_chat_support.customer_chat_support_data.order(id: :desc).page(params[:page])
      render json: @customer_chat_support_data
    end

    def create
      customer_chat_support = current_customer.customer_chat_support
      chat_datum = current_customer.customer_chat_support_data.new(data_params.merge(customer_chat_support: customer_chat_support))
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
