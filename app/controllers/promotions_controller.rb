class PromotionsController < ApplicationController
  
  before_action :set_promotion, only: [:show, :edit, :update, :destroy]

  # GET /promotions
  def index
    @grid = PromotionsGrid.new(params[:promotions_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  # GET /promotions/1
  def show
    authorize @promotion
  end

  # GET /promotions/new
  def new
    @promotion = Promotion.new
    authorize @promotion
  end

  # GET /promotions/1/edit
  def edit
    authorize @promotion
  end

  # POST /promotions
  def create
    @promotion = Promotion.new(promotion_params)
    authorize @promotion
    if @promotion.save
      redirect_to @promotion, notice: 'Promotion was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /promotions/1
  def update
    authorize @promotion
    if @promotion.update(promotion_params)
      redirect_to @promotion, notice: 'Promotion was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /promotions/1
  def destroy
    authorize @promotion
    @promotion.destroy
    redirect_to promotions_url, notice: 'Promotion was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promotion
      @promotion = Promotion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def promotion_params
      params.require(:promotion).permit(:title, :image, :image_cache, :body, :start_date, :end_date, :sent)
    end
end
