class UsersController < ApplicationController
  def index
    @grid = UsersGrid.new(params[:users_grid]) do |scope|
      scope.page(params[:page])
    end
  end
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    # @users = User.all
    @grid = UsersGrid.new(params[:users_grid]) do |scope|
      scope.page(params[:page])
    end
  end
  
  def show
  end

  def new
    @user = User.new
  end
  
  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update_without_password(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
     @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :avatar, :email, :password, :avatar_cache)
    end
end
