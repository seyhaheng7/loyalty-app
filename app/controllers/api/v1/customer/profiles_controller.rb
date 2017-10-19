module Api::V1::Customer
  class ProfilesController < BaseController
    swagger_controller :profiles, 'Profiles'

    swagger_api :index do
      summary 'Fetches all user index'
      response :unauthorized
      response :not_acceptable
    end

    def index
      render json: :current_user, status: :ok
    end

  end
end