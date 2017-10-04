class CustomerChatSupportsController < ApplicationController
  before_action :set_customer_chat_support, only: [:show]

  # GET /customer_chat_supports
  def index
    @grid = CustomerChatSupportsGrid.new(params[:customer_chat_supports_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  # GET /customer_chat_supports/1
  def show
    authorize @customer_chat_support
    respond_to do |format|
      format.html
      format.json { render json: @customer_chat_support.customer_chat_support_data }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_chat_support
      @customer_chat_support = CustomerChatSupport.find(params[:id])
    end
    
end
