module Api::V1::Customer
  class BaseController < ActionController::API
    # set up swagger docs
    include Swagger::Docs::ImpotentMethods
    Swagger::Docs::Generator::set_real_methods

    include Pundit
    include DeviseTokenAuth::Concerns::SetUserByToken

    # before_action ->{ binding.pry }
    before_action :check_access_country!
    before_action :authenticate_customer!
    before_action :check_customer_verification!, if: :customer_signed_in?

    # user not allow to access
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def user_not_authorized
      # error! :forbidden
      error = { errors: ['Action not allowed'] }
      render json: error, status: 403
    end

    # Trick to make token auth work start
    def authenticate_user!
      authenticate_customer!
    end

    def current_user
      current_customer
    end
    # Trick to make token auth work end


    def devise_token_controller?
      params[:controller].include? 'devise_token_auth'
    end

    def check_access_country!
    if !Rails.env.development? && ENV['RESTRICT_ACCESS'] == 'true'
      country = GEOIP.country(request.remote_ip)
      if country.country_name != 'Cambodia'
        render plain: 'Restrict Access from your country', status: 401
      end
    end
  end

    # swagger doc authentication header request
    class << self
      Swagger::Docs::Generator::set_real_methods

      def inherited(subclass)
        super
        subclass.class_eval do
          setup_basic_api_documentation
        end
      end

      private
      def setup_basic_api_documentation
        [:index, :show, :create, :update, :delete].each do |api_action|
          swagger_api api_action do
            param :header, 'access-token', :string, :required, 'Authentication token'
            param :header, 'token-type', :string, :required, 'Bearer'
            param :header, 'client', :string, :required, 'Simultaneous sessions on different clients'
            param :header, 'expiry', :string, :required, 'The date at which the current session will expire'
            param :header, 'uid', :string, :required, 'A unique value that is used to identify the user'
          end
        end
      end
    end

    private

    def check_customer_verification!
      if !current_user.completed_profile?
        error = { errors: ['profile not completed'], user: ActiveModelSerializers::SerializableResource.new(current_customer) }
        render json: error, status: 401
      elsif !current_customer.verified?
        error = { errors: ['Unverified account'] }
        render json: error, status: 401
      end
    end
  end
end
