module Api::V1
  class BaseController < ActionController::API
    before_action :authenticate_user!
    include Pundit

    include DeviseTokenAuth::Concerns::SetUserByToken
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def user_not_authorized
      # error! :forbidden
      head 403
      error = { error: 'Action not allowed.', error_description: 'Sorry, you are not allowed to perform this action.'}
      expose error
    end

  end
end