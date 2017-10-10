module Api::V1::Customer
  class ReceiptsController < BaseController
    before_action :set_receipt, only: [:show, :update, :destroy]

    swagger_controller :receipts, 'Receipts'

    def self.add_common_params(api)
      api.param :form, 'receipt[receipt_id]', :string, :required, 'Receipt_id'
      api.param :form, 'receipt[total]', :float, :required, 'Total'
      api.param :form, 'receipt[capture]', :string, :required, 'Capture'
      api.param :form, 'receipt[new_store][name]', :string, :optional, 'New Store Name'
      api.param :form, 'receipt[new_store][location_id]', :string, :optional, 'New Store Location Id'
      api.param :form, 'receipt[store_id]', :integer, :optional, 'Status'
    end

    swagger_api :index do
      summary 'Fetches all receipts'
      param :query, :page, :integer, :optional, "Page number"
      response :unauthorized
      response :success
      response :not_acceptable, "The request you made is not acceptable"
      response :requested_range_not_satisfiable
    end

    swagger_api :show do
      summary 'Get a receipt'
      notes 'get information of receipt by passing his receipt id'
      param :path, :id, :integer, :required, 'ID of Receipt'
      response :ok
      response :not_found
    end

    swagger_api :create do |api|
      summary 'create a receipt'
      notes 'make sure you pass parameters in receipt'
      Api::V1::Customer::ReceiptsController::add_common_params(api)
      response :ok
    end

    def index
      @receipts = current_customer.receipts.page(params[:page])
      render json: @receipts, status: :ok
    end

    def show
      render json: @receipt
    end

    def create
      @receipt = current_customer.receipts.new(receipt_params)
      if @receipt.save
        render json: @receipt, status: :created, location: @receipt
      else
        render json: @receipt, status: :unprocessable_entity
      end
    end

    private

      def set_receipt
        @receipt = current_customer.receipts.find(params[:id])
      end

      def receipt_params
        params.require(:receipt).permit(:total,:receipt_id, :capture, :store_id, new_store: [:name, :location_id])
      end
  end
end
