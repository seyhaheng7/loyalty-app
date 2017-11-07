module Api::V1::Customer
  class NearByCustomersController < BaseController

    swagger_controller :near_by_customers, 'NearByCustomer'

    swagger_api :index do
      summary 'Fetches all customers'
      param :query, :page, :integer, :optional, "Page number"
      param :query, :limit, :integer, :optional, "Limit user (default 10)"
      response :unauthorized
      response :not_acceptable
    end

    def index
      @customers = Customer.near([current_customer.lat, current_customer.long], 1, units: :km).page(params[:page]).per(params[:limit]||10)
      render json: @customers, status: :ok
    end
  end
end
