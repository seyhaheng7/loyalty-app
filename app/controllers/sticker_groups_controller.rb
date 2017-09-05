class StickerGroupsController < ApplicationController
  before_action :set_sticker_group, only: [:show, :edit, :update, :destroy]

  # GET /sticker_groups
  def index
    @grid = StickerGroupsGrid.new(params[:sticker_groups_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  # GET /sticker_groups/1
  def show
    authorize @sticker_group
  end

  # GET /sticker_groups/new
  def new
    @sticker_group = StickerGroup.new
    authorize @sticker_group
  end

  # GET /sticker_groups/1/edit
  def edit
    authorize @sticker_group
  end

  # POST /sticker_groups
  def create
    @sticker_group = StickerGroup.new(sticker_group_params)
    authorize @sticker_group

    if @sticker_group.save
      redirect_to @sticker_group, notice: 'StickerGroup was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sticker_groups/1
  def update
    authorize @sticker_group
    if @sticker_group.update(sticker_group_params)
      redirect_to @sticker_group, notice: 'StickerGroup was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sticker_groups/1
  def destroy
    authorize @sticker_group
    @sticker_group.destroy
    redirect_to sticker_groups_url, notice: 'StickerGroup was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sticker_group
      @sticker_group = StickerGroup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sticker_group_params
      params.require(:sticker_group).permit(:name, :image)
    end
end
