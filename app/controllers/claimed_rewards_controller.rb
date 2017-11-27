class ClaimedRewardsController < ApplicationController
  before_action :set_claimed_reward, only: [:show, :destroy, :approve, :reject]

  # GET /claimed_rewards
  def index
    @grid = ClaimedRewardsGrid.new(params[:claimed_rewards_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  # GET /claimed_rewards/1
  def show
    authorize @claimed_reward
  end

  # DELETE /claimed_rewards
  def destroy
    authorize @claimed_reward
    @claimed_reward.destroy
    redirect_to claimed_rewards_url, notice: 'Claimed Reward was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claimed_reward
      @claimed_reward = ClaimedReward.find(params[:id])
    end

end
