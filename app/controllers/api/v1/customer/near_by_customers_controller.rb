module Api::V1::Customer
  class NearByCustomersController < BaseController

    swagger_controller :near_by_customers, 'NearByCustomer'

    swagger_api :index do
      summary 'Fetches all customers'
      response :unauthorized
      response :not_acceptable
    end

    def index
      @customers = Customer.near([current_customer.lat, current_customer.long], 1, units: :km).page(params[:page])
      render json: @customers, status: :ok
    end
  end
end
