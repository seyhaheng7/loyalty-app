module Api::V1::Merchant
  class ClaimedRewardsController < BaseController

    swagger_controller :claimed_rewards, 'Merchant ClaimedRewards'
    swagger_api :given do
      summary 'Put a claimed_rewards'
      notes 'get information of receipt by passing his receipt id'
      param :param, :given, :sting, :required, 'Given Claimed Reward'
      response :ok
      response :not_found
    end

    def given
      @claimed_reward = current_merchant.claimed_rewards.find_by!(qr_token: params[:qr_token])
      if @claimed_reward.given?
        render json: { errors: 'already given' }, status: 405
      else
        if @claimed_reward.present?
          @claimed_reward.update given: true
          render json: @claimed_reward
        else
          head 404, "content_type" => 'text/plain'
        end
      end
    end

  end
end
