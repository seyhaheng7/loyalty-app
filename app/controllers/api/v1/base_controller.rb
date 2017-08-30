module Api::V1
  class BaseController < ActionController::API
    include Swagger::Docs::ImpotentMethods
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Pundit
    
    before_action :authenticate_user!

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def user_not_authorized
      # error! :forbidden
      head 403
      error = { error: 'Action not allowed.', error_description: 'Sorry, you are not allowed to perform this action.'}
      expose error
    end

    # swagger doc header request
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

  end
end