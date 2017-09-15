class ReceiptsController < ApplicationController
  before_action :set_receipt, only: [:show, :edit, :update, :destroy, :approve, :reject]

  # GET /receipts
  def index
    @grid = ReceiptsGrid.new(params[:receipts_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  # GET /receipts/1
  def show
    authorize @receipt
  end

  # GET /receipts/new
  def new
    @receipt = Receipt.new
    authorize @receipt
  end

  # GET /receipts/1/edit
  def edit
    authorize @receipt
  end

  # POST /receipts
  def create
    @receipt = Receipt.new(receipt_params)
    authorize @receipt

    if @receipt.save
      redirect_to @receipt, notice: 'Receipt was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /receipts/1
  def update
    authorize @receipt
    if @receipt.update(receipt_params)
      redirect_to @receipt, notice: 'Receipt was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /receipts/1
  def destroy
    authorize @receipt
    @receipt.destroy
    redirect_to receipts_url, notice: 'Receipt was successfully deleted.'
  end

  # APPROVE /receipts/1
  def approve
    authorize @receipt

    if @receipt.update(receipt_params.merge(managed_by: current_user))
      @receipt.approving!
      redirect_to @receipt, notice: 'Receipt was successfully approved.'
    else
      redirect_to @receipt, notice: 'Receipt was unsuccessfully approved.'
    end
  end

  # REJECT /receipts/1
  def reject
    authorize @receipt

    if @receipt.update(managed_by: current_user)
      @receipt.rejecting!
      redirect_to @receipt, notice: 'Receipt was successfully rejected.'
    else
      redirect_to @receipt, notice: 'Receipt was unsuccessfully rejected.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_receipt
      @receipt = Receipt.find(params[:id]).decorate
    end

    # Only allow a trusted parameter "white list" through.
    def receipt_params
      params.require(:receipt).permit(:receipt_id, :total, :capture, :capture_cache, :status, :store_id, :customer_id, :earned_points ,:managed_by)
    end
end
