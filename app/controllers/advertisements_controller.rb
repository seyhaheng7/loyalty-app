class AdvertisementsController < ApplicationController

  before_action :set_advertisement, only: [:show, :edit, :update, :destroy]

  # GET /advertisements
  def index
    @grid = AdvertisementsGrid.new(params[:advertisements_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  # GET /advertisements/1
  def show
    authorize @advertisement
    count = @advertisement.view.to_i + 1
    @advertisement.update_columns(:view => count)
  end

  # GET /advertisements/new
  def new
    @advertisement = Advertisement.new
    authorize @advertisement
  end

  # GET /advertisements/1/edit
  def edit
    authorize @advertisement
  end

  # POST /advertisements
  def create
    @advertisement = Advertisement.new(advertisement_params)
    authorize @advertisement
    if @advertisement.save
      redirect_to @advertisement, notice: 'Advertisement was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /advertisements/1
  def update
    authorize @advertisement
    if @advertisement.update(advertisement_params)
      redirect_to @advertisement, notice: 'Advertisement was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /advertisements/1
  def destroy
    authorize @advertisement
    @advertisement.destroy
    redirect_to advertisements_url, notice: 'Advertisement was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advertisement
      @advertisement = Advertisement.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def advertisement_params
      params.require(:advertisement).permit(:name, :banner, :banner_cache, :active, :price, :view ,:for_page, :lat, :long, :address, :phone, :website, :start_date, :end_date)
    end
end
