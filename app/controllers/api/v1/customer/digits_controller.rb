module Api::V1::Customer
  class DigitsController < BaseController
    swagger_controller :digits, 'Send Login Digit'

    swagger_api :send_digit do
      summary 'Send Login Digit'
      param :form, :phone, :string, :required, 'Phone number'
      response :ok
      response :not_found
    end

    skip_before_action :authenticate_customer!

    def send_digit
      @customer = Customer.find_by phone: params[:phone]
      if @customer.present?
        if @customer.phone_provider?
          if @customer.verified?
            @customer.send_login_digit
            head :ok
          else
            errors = ['not yet verified']
            render json: { errors:  errors }, status: 401
          end
        else
          errors = ["you registered with #{@customer.provider}"]
          render json: { errors:  errors }, status: 401
        end
      else
        errors = ['not yet registered']
        render json: { errors:  errors }, status: :not_found
      end
    end
  end
end
