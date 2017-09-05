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

  # APPROVE /claimed_rewards
  def approve
    authorize @claimed_reward

    if @claimed_reward.update(managed_by: current_user)
      @claimed_reward.approving!
      redirect_to @claimed_reward, notice: 'Claimed Reward was successfully approved.'
    else
      redirect_to @claimed_reward, notice: 'Claimed Reward was unsuccessfully approved.'
    end
  end

  # REJECT /claimed_rewards
  def reject
    authorize @claimed_reward
    if @claimed_reward.update(managed_by: current_user)
      @claimed_reward.rejecting!
      redirect_to @claimed_reward, notice: 'Claimed Reward was successfully rejected.'
    else
      redirect_to @claimed_reward, notice: 'Claimed Reward was successfully rejected.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claimed_reward
      @claimed_reward = ClaimedReward.find(params[:id]).decorate
    end
  
end
