module Api::V1
  class BaseController < ActionController::API
    include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :authenticate_user!
    include Pundit

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def user_not_authorized
      # error! :forbidden
      head 403
      error = { error: 'Action not allowed.', error_description: 'Sorry, you are not allowed to perform this action.'}
      expose error
    end

  end
end