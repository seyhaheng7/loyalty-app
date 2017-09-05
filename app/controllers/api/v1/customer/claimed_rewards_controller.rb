module Api::V1::Customer
  class ClaimedRewardsController < BaseController

    swagger_controller :claimed_rewards, 'ClaimedRewards'

    def self.add_common_params(api)
      api.param :form, 'claimed_reward[reward_id]', :integer, :optional, 'Reward'
    end

    swagger_api :create do |api|
      summary 'create a claimed_reward'
      notes 'make sure you pass parameters in claimed_reward'
      Api::V1::ClaimedRewardController::add_common_params(api)
      response :ok
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
