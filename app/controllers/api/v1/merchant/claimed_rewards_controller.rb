module Api::V1::Merchant
  class ClaimedRewardsController < BaseController

    swagger_controller :claimed_rewards, 'Merchant ClaimedRewards'

    swagger_api :index do
      summary 'Fetches all approved claimed rewards'
      param :query, :page, :integer, :optional, "Page number"
      param :query, :status, :string, :optional, "Filter by approved, rejected, submitted"
      param :query, :given, :string, :optional, "[true, false]"
      response :unauthorized
      response :success
      response :not_acceptable, "The request you made is not acceptable"
      response :requested_range_not_satisfiable
    end

    swagger_api :given do
      summary 'Give reward'
      notes 'get information of receipt by passing his receipt id'
      param :header, 'access-token', :string, :required, 'Authentication token'
      param :header, 'token-type', :string, :required, 'Bearer'
      param :header, 'client', :string, :required, 'Simultaneous sessions on different clients'
      param :header, 'expiry', :string, :required, 'The date at which the current session will expire'
      param :header, 'uid', :string, :required, 'A unique value that is used to identify the user'
      param :param, :qr_token, :sting, :required, 'Token Claimed Reward'
      response :ok
      response :not_found
    end


    def index
      @claimed_rewards = current_merchant.claimed_rewards.approved.filter(params).page(params[:page]).includes(:customer, :reward)
      render json: @claimed_rewards, status: :ok
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
