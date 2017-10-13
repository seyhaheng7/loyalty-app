module Api::V1::Customer
  class CustomersController < BaseController
    swagger_controller :customers, 'Customers'

    swagger_api :profile do
      summary 'Fetches customer profile'
      response :unauthorized
      response :not_acceptable
    end

    def profile
      render json: current_customer
    end
    
  end
end