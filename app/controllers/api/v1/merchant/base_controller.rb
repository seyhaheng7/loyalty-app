module Api::V1::Merchant
  class BaseController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    # set up swagger docs
    include Swagger::Docs::ImpotentMethods
    Swagger::Docs::Generator::set_real_methods

    include Pundit
    include DeviseTokenAuth::Concerns::SetUserByToken

    before_action :check_access_country!
    before_action :authenticate_merchant!

    # user not allow to access
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def user_not_authorized
      # error! :forbidden
      error = { errors: ['Action not allowed'] }
      render json: error, status: 403
    end

    # Trick to make token auth work start
    def authenticate_user!
      authenticate_merchant!
    end

    def current_user
      current_merchant
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

    def not_found
      render json: { error: "record not found" }, status: :not_found
    end
  end
end
