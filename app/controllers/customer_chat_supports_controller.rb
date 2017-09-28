class CustomerChatSupportsController < ApplicationController
  before_action :set_customer_chat_support, only: [:show, :edit, :update, :destroy]

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

  # GET /customer_chat_supports/new
  def new
    @customer_chat_support = CustomerChatSupport.new
    authorize @customer_chat_support
  end

  # GET /customer_chat_supports/1/edit
  def edit
    authorize @customer_chat_support
  end

  # POST /customer_chat_supports
  def create
    @customer_chat_support = CustomerChatSupport.new(customer_chat_support_params)
    authorize @customer_chat_support

    if @customer_chat_support.save
      redirect_to @customer_chat_support, notice: 'Customer chat support was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /customer_chat_supports/1
  def update
    authorize @customer_chat_support
    if @customer_chat_support.update(customer_chat_support_params)
      redirect_to @customer_chat_support, notice: 'Customer chat support was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /customer_chat_supports/1
  def destroy
    authorize @customer_chat_support
    @customer_chat_support.destroy
    redirect_to customer_chat_supports_url, notice: 'Customer chat support was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_chat_support
      @customer_chat_support = CustomerChatSupport.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def customer_chat_support_params
      params.require(:customer_chat_support).permit(:customer_id)
    end
end
