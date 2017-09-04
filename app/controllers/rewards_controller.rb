class RewardsController < ApplicationController
  before_action :set_reward, only: [:show, :edit, :update, :destroy]

  # GET /rewards
  def index
    @grid = RewardsGrid.new(params[:rewards_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  # GET /rewards/1
  def show
    authorize @reward
  end

  # GET /rewards/new
  def new
    @reward = Reward.new
    authorize @reward
  end

  # GET /rewards/1/edit
  def edit
    authorize @reward
  end

  # POST /rewards
  def create
    @reward = Reward.new(reward_params)
    authorize @reward

    if @reward.save
      redirect_to @reward, notice: 'Reward was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /rewards/1
  def update
    authorize @reward
    if @reward.update(reward_params)
      redirect_to @reward, notice: 'Reward was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /rewards/1
  def destroy
    authorize @reward
    @reward.destroy
    redirect_to rewards_url, notice: 'Reward was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reward
      @reward = Reward.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reward_params
      params.require(:reward).permit(:name, :image, :require_points, :quantity, :company_id)
    end
end
