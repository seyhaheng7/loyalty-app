class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

 # GET /customers
  def index
    @grid = CustomersGrid.new(params[:customers_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  # GET /customers/1
  def show
    authorize @customer
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    authorize @customer
  end

  # GET /customers/1/edit
  def edit
    authorize @customer
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)
    authorize @customer

    if @customer.save
      redirect_to @customer, notice: 'Customer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /customers/1
  def update
    authorize @customer
    if @customer.update(customer_params)
      redirect_to @customer, notice: 'Customer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /customers/1
  def destroy
    authorize @customer
    @customer.destroy
    redirect_to customers_url, notice: 'Customer was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def customer_params
      params.require(:customer).permit(:name, :email, :phone, :address, :avatar, :gender, :password, :current_points, :role, :lat, :long, :last_update, :confirmation_code, :confirmation_at, :language, :current_sign_in_ip, :avatar_cache)
    end
end
