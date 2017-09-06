module Api::V1::Customer
  class UsersController < BaseController
    before_action :set_user, only: [:show, :update, :destroy]

    swagger_controller :users, 'Users'

    def self.add_common_params(api)
      api.param :form, 'user[name]', :string, :optional, 'Name'
      api.param :form, 'user[email]', :string, :optional, 'Email'
    end

    swagger_api :index do
      summary 'Fetches all users'
      # param :form, 'user[lat]', :float, :optional, 'Lat'
      # param :form, 'user[long]', :float, :optional, 'Long'
      response :unauthorized
      response :not_acceptable
    end

    def index
      @users = User.page(params[:page])
      render json: @users, status: :ok
    end

    swagger_api :show do
      summary 'Get a user'
      notes 'get information of user by passing his user id'
      param :path, :id, :integer, :required, 'ID of User'
      response :ok
      response :not_found
    end

    def show
      render json: @user
    end

    swagger_api :create do |api|
      summary 'create a user'
      notes 'make sure you pass parameters in user'
      Api::V1::Customer::UsersController::add_common_params(api)
      response :ok
      response :unprocessable_entity
    end

    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created, location: @user
      else
        render json: @user, status: :unprocessable_entity
      end
    end

    swagger_api :update do |api|
      summary 'update user'
      notes 'make sure you pass parameters in users'
      param :path,  :id, :integer, :required, 'ID of User'
      Api::V1::Customer::UsersController::add_common_params(api)
      response :ok
      response :unprocessable_entity
      response :not_found
    end

    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user, status: :unprocessable_entity
      end
    end

    swagger_api :destroy do
      summary 'Delete a user'
      notes 'Delete user by passing his user id'
      param :path, :id, :integer, :required, 'ID of User'
      response :ok
      response :unprocessable_entity
      response :not_found
    end

    def destroy
      @user.destroy
      head :no_content
    end

    private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:name, :email)
      end
  end
end