module Api::V1::Customer
  class CategoriesController < BaseController
    before_action :set_category, only: [:show, :update, :destroy]

    swagger_controller :categories, 'Categories'

    swagger_api :index do
      summary 'Fetches all categories'
      notes "This lists all the active categories"
      param :query, :page, :integer, :optional, "Page number"
      response :unauthorized
      response :success
      response :not_acceptable, "The request you made is not acceptable"
      response :requested_range_not_satisfiable
    end

    swagger_api :show do
      summary 'Get a category'
      notes 'get information of category by passing his category id'
      param :path, :id, :integer, :required, 'ID of Category'
      response :not_found
      response :ok, "Success", :User
      response :unauthorized
      response :not_acceptable
      response :unprocessable_entity
    end


    def index
      @categories = Category.all.page(params[:page])
      render json: @categories, status: :ok
    end

    def show
      render json: @category
    end

    private

      def set_category
        @category = Category.find(params[:id])
      end
  end
end
