class MerchantChatSupportsController < ApplicationController
  before_action :set_merchant_chat_support, only: [:show]

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant_chat_support
      @merchant_chat_support = MerchantChatSupport.find(params[:id])
    end

end
