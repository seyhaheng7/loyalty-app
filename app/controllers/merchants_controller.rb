class MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :edit, :update, :destroy]

  # GET /merchants
  def index
    @grid = MerchantsGrid.new(params[:merchants_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  def show
    authorize @merchant
  end

  def new
    @merchant = Merchant.new
    authorize @merchant
  end

  def edit
    authorize @merchant
  end

  def create
    @merchant = Merchant.new(merchant_params)
    authorize @merchant
    if @merchant.save
      redirect_to @merchant, notice: 'Merchant was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @merchant
    if @merchant.update_without_password(merchant_params)
      redirect_to @merchant, notice: 'Merchant was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    authorize @merchant
    @merchant.destroy
    redirect_to merchants_url, notice: 'Merchant was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant
      @merchant = Merchant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def merchant_params
      params.require(:merchant).permit(:name, :email, :phone, :avatar, :password, :avatar_cache, :store_id)
    end
end
