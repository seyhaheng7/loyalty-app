class VideoAdsController < ApplicationController
  before_action :set_video_ad, only: [:show, :edit, :update, :destroy]

  # GET /video_ads
  def index
    @grid = VideoAdsGrid.new(params[:video_ads_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  # GET /video_ads/1
  def show
    authorize @video_ad
  end

  # GET /video_ads/new
  def new
    @video_ad = VideoAd.new
    authorize @video_ad
  end

  # GET /video_ads/1/edit
  def edit
    authorize @video_ad
  end

  # POST /video_ads
  def create
    @video_ad = VideoAd.new(video_ad_params)
    authorize @video_ad
    if @video_ad.save
      redirect_to @video_ad, notice: 'Video was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /video_ads/1
  def update
    authorize @video_ad
    if @video_ad.update(video_ad_params)
      redirect_to @video_ad, notice: 'Video was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /video_ads/1
  def destroy
    authorize @video_ad
    @video_ad.destroy
    redirect_to video_ads_url, notice: 'Video was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video_ad
      @video_ad = VideoAd.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def video_ad_params
      params.require(:video_ad).permit(:title, :video, :start_date, :end_date, :earned_points)
    end
end
