class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  # GET /stores
  def index
    @grid = StoresGrid.new(params[:stores_grid]) do |scope|
      scope.page(params[:page]).without_deleted
    end
    authorize @grid.assets
  end

  # GET /stores/1
  def show
    authorize @store
  end

  # GET /stores/new
  def new
    @store = Store.new
    authorize @store
  end

  # GET /stores/1/edit
  def edit
    authorize @store
  end

  # POST /stores
  def create
    @store = Store.new(store_params)
    authorize @store

    if @store.save
      redirect_to @store, notice: 'Store was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /stores/1
  def update
    authorize @store

    if @store.update(store_params)
      redirect_to @store, notice: 'Store was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /stores/1
  def destroy
    authorize @store

    @store.destroy
    redirect_to stores_url, notice: 'Store was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def store_params
      params.require(:store).permit(:name, :lat, :long, :address, :company_id, :location_id, :website, :phone, :open_and_close, :email, :facebook)
    end
end
