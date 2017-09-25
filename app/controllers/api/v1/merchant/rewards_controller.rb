module Api::V1::Merchant
  class RewardsController < BaseController
    before_action :set_reward, only: [:show]

    swagger_controller :rewards, 'Merchant Available Rewards '

    swagger_api :index do
      summary 'Fetches all rewards'
      param :query, :page, :integer, :optional, "Page number"

      response :unauthorized
      response :success
      response :not_acceptable, "The request you made is not acceptable"
      response :requested_range_not_satisfiable
    end

    def index
      @rewards = current_merchant.store.rewards.available.page(params[:page])
      render json: @rewards, status: :ok
    end

  end
end
