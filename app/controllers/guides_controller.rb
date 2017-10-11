class GuidesController < ApplicationController
  
  before_action :set_guide, only: [:show, :edit, :update, :destroy]

  # GET /guides
  def index
    @grid = GuidesGrid.new(params[:guides_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  # GET /guides/1
  def show
    authorize @guide
  end

  # GET /guides/new
  def new
    @guide = Guide.new
    authorize @guide
  end

  # GET /guides/1/edit
  def edit
    authorize @guide
  end

  # POST /guides
  def create
    @guide = Guide.new(guide_params)
    authorize @guide
    if @guide.save
      redirect_to @guide, notice: 'Guide was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /guides/1
  def update
    authorize @guide
    if @guide.update(guide_params)
      redirect_to @guide, notice: 'Guide was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /guides/1
  def destroy
    authorize @guide
    @guide.destroy
    redirect_to guides_url, notice: 'Guide was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guide
      @guide = Guide.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def guide_params
      params.require(:guide).permit(:title, :youtube_url, :thumbnail, :thumbnail_cache)
    end
end
