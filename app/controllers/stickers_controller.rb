class StickersController < ApplicationController
  before_action :set_sticker, only: [:show, :edit, :update, :destroy]

  # GET /stickers
  def index
    @grid = StickersGrid.new(params[:stickers_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  # GET /stickers/1
  def show
    authorize @sticker
  end

  # GET /stickers/new
  def new
    @sticker = Sticker.new
    authorize @sticker
  end

  # GET /stickers/1/edit
  def edit
    authorize @sticker
  end

  # POST /stickers
  def create
    @sticker = Sticker.new(sticker_params)
    authorize @sticker

    if @sticker.save
      redirect_to @sticker, notice: 'Sticker was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /stickers/1
  def update
    authorize @sticker
    if @sticker.update(sticker_params)
      redirect_to @sticker, notice: 'Sticker was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /stickers/1
  def destroy
    authorize @sticker
    @sticker.destroy
    redirect_to stickers_url, notice: 'Sticker was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sticker
      @sticker = Sticker.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sticker_params
      params.require(:sticker).permit(:name, :image, :sticker_group_id)
    end
end
