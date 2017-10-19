class MerchantChatSupportsController < ApplicationController
  before_action :set_merchant_chat_support, only: [:show, :seen_to_now]
  before_action :set_seen_at_to_now, only: [:show]

  # GET /merchant_chat_supports
  def index
    @merchant_chat_supports = MerchantChatSupport.lastest_chat_order.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /merchant_chat_supports/1
  def show
    authorize @merchant_chat_support
    @merchant_chat_support_data = @merchant_chat_support.merchant_chat_support_data.order(id: :desc).page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def seen_to_now
    @merchant_chat_support.seen_at = DateTime.now
    @merchant_chat_support.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant_chat_support
      @merchant_chat_support = MerchantChatSupport.find(params[:id])
    end

    def set_seen_at_to_now
      @merchant_chat_support.seen_at = DateTime.now
      @merchant_chat_support.save
    end

end
