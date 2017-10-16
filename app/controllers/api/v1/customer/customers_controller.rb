module Api::V1::Customer
  class CustomersController < BaseController
    swagger_controller :customers, 'Customers'

    swagger_api :profile do
      summary 'Fetches customer profile'
      param :header, 'access-token', :string, :required, 'Authentication token'
      param :header, 'token-type', :string, :required, 'Bearer'
      param :header, 'client', :string, :required, 'Simultaneous sessions on different clients'
      param :header, 'expiry', :string, :required, 'The date at which the current session will expire'
      param :header, 'uid', :string, :required, 'A unique value that is used to identify the user'
      response :unauthorized
      response :not_acceptable
    end

    def profile
      render json: current_customer
    end

  end
end
