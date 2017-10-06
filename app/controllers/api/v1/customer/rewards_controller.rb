module Api::V1::Customer
  class RewardsController < BaseController
    before_action :set_reward, only: [:show]

    swagger_controller :rewards, 'Rewards'

    swagger_api :index do
      summary 'Fetches all rewards'
      param :query, :page, :integer, :optional, "Page number"
      param :query, :store_name, :string, :optional, "Store name"

      response :unauthorized
      response :success
      response :not_acceptable, "The request you made is not acceptable"
      response :requested_range_not_satisfiable
    end

    swagger_api :show do
      summary 'Get a reward'
      notes 'get information of reward by passing his reward id'
      param :path, :id, :integer, :required, 'ID of Reward'
      response :not_found
      response :ok, "Success", :User
      response :unauthorized
      response :not_acceptable
    end

    def index
      @rewards = Reward.available.filter(params).order_with(params).page(params[:page])
      render json: @rewards, status: :ok
    end

    def show
      render json: @reward
    end

    private

      def set_reward
        @reward = Reward.find(params[:id])
      end
  end
end
