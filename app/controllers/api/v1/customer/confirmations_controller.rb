module Api::V1::Customer
  class ConfirmationsController < BaseController
    swagger_controller :confirmations, 'Customer Confirmation'

    swagger_api :confirm do
      summary 'Confirm Customer By SMS'
      param :form, :phone, :string, :required, 'Phone number'
      param :form, :verification_code, :string, :required, '4 Digit Code From SMS'
      response :ok
      response :unprocessable_entity
    end

    skip_before_action :authenticate_customer!

    def confirm
      customer = Customer.able_to_verify.find_by(phone: params[:phone], verification_code: params[:verification_code])
      if customer.present?
        customer.confirm!
        head :ok
      else
        errors = 'verification fail'
        render json: { errors:  errors }, status: :unprocessable_entity
      end
    end
  end
end
