module Api::V1::Customer
  class PrivacyPoliciesController < BaseController

    swagger_controller :privacy_policies, 'Privacy_policies'

    swagger_api :index do
      summary 'Get a privacy_policy'
      notes 'get information of privacy_policy by passing his privacy_policy id'
      param :path, :id, :integer, :required, 'ID of Privacy_policy'
      response :ok
      response :not_found
    end

    def index
      @privacy_policy = PrivacyPolicy.first_or_create
      render json: @privacy_policy
    end
  end
end
