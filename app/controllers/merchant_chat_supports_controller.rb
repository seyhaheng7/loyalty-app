class MerchantChatSupportsController < ApplicationController
  before_action :set_merchant_chat_support, only: [:show, :edit, :update, :destroy]

  # GET /merchant_chat_supports
  def index
    @grid = MerchantChatSupportsGrid.new(params[:merchant_chat_supports_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  # GET /merchant_chat_supports/1
  def show
    authorize @merchant_chat_support
    respond_to do |format|
      format.html
      format.json { render json: @merchant_chat_support.merchant_chat_support_data }
    end

  end

  # GET /merchant_chat_supports/new
  def new
    @merchant_chat_support = MerchantChatSupport.new
    authorize @merchant_chat_support
  end

  # GET /merchant_chat_supports/1/edit
  def edit
    authorize @merchant_chat_support
  end

  # POST /merchant_chat_supports
  def create
    @merchant_chat_support = MerchantChatSupport.new(merchant_chat_support_params)
    authorize @merchant_chat_support
    if @merchant_chat_support.save
      redirect_to @merchant_chat_support, notice: 'Merchant chat support was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /merchant_chat_supports/1
  def update
    authorize @merchant_chat_support
    if @merchant_chat_support.update(merchant_chat_support_params)
      redirect_to @merchant_chat_support, notice: 'Merchant chat support was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /merchant_chat_supports/1
  def destroy
    authorize @merchant_chat_support
    @merchant_chat_support.destroy
    redirect_to merchant_chat_supports_url, notice: 'Merchant chat support was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant_chat_support
      @merchant_chat_support = MerchantChatSupport.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def merchant_chat_support_params
      params.require(:merchant_chat_support).permit(:merchant_id)
    end
end
