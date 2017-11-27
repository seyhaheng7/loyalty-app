module Api::V1::Customer
  class ClaimedRewardsController < BaseController

    swagger_controller :claimed_rewards, 'ClaimedRewards'

    def self.add_common_params(api)
      api.param :form, 'claimed_reward[reward_id]', :integer, :required, 'Reward'
    end

    swagger_api :index do
      summary 'Fetches all claimed_reward'
      param :query, :page, :integer, :optional, "Page number"

      response :unauthorized
      response :success
      response :not_acceptable, "The request you made is not acceptable"
      response :requested_range_not_satisfiable
    end

    swagger_api :create do |api|
      summary 'create a claimed_reward'
      notes 'make sure you pass parameters in claimed_reward'
      Api::V1::Customer::ClaimedRewardsController::add_common_params(api)
      response :ok
    end

    def index
      @claimed_rewards = current_user.claimed_rewards.filter(params).page(params[:page]).includes(:customer, reward: [{store: :location}])
      render json: @claimed_rewards, status: :ok
    end

    def create
      @claimed_reward = current_user.claimed_rewards.new(claimed_reward_params)
      if @claimed_reward.save
        render json: @claimed_reward, status: :created
      else
        render json: @claimed_reward, status: :unprocessable_entity
      end
    end

    private
      def claimed_reward_params
        params.require(:claimed_reward).permit(:reward_id)
      end
  end
end
