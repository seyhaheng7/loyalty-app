class CustomerChatSupportsController < ApplicationController
  before_action :set_customer_chat_support, only: [:show, :seen_to_now]
  before_action :set_seen_at_to_now, only: [:show]

  # GET /customer_chat_supports
   def index
    @customer_chat_supports = CustomerChatSupport.lastest_chat_order.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /customer_chat_supports/1
  def show
    authorize @customer_chat_support
    @customer_chat_support_data = @customer_chat_support.customer_chat_support_data.order(id: :desc).page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def seen_to_now
    @customer_chat_support.seen_at = DateTime.now
    @customer_chat_support.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_chat_support
      @customer_chat_support = CustomerChatSupport.find(params[:id])
    end

    def set_seen_at_to_now
      @customer_chat_support.seen_at = DateTime.now
      @customer_chat_support.save
    end
    
end
