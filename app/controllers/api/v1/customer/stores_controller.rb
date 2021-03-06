module Api::V1::Customer
  class StoresController < BaseController
    before_action :set_store, only: [:show, :update, :destroy]

    swagger_controller :stores, 'Stores'

    swagger_api :index do
      summary 'Fetches all stores'
      notes "This lists all the active stores"
      param :query, :page, :integer, :optional, "Page number"
      param :query, 'order[name]', :string, :optional, '[desc, asc]'
      param :query, :name, :string, :optional
      param :query, :lat, :float, :optional
      param :query, :long, :float, :optional
      param :query, :category_id, :integer, :optional
      param :query, :only_partners, :boolean, :optional, '[true, false]'
      response :unauthorized
      response :success
      response :not_acceptable, "The request you made is not acceptable"
      response :requested_range_not_satisfiable
    end

    swagger_api :show do
      summary 'Get a store'
      notes 'get information of store by passing his store id'
      param :path, :id, :integer, :required, 'ID of Store'
      response :not_found
      response :ok, "Success", :User
      response :unauthorized
      response :not_acceptable
    end

    def index
      @stores = Store.filter(params).order_by(params[:order]).page(params[:page]).includes(:company, :location, :store_banners)
      render json: @stores, status: :ok
    end

    def show
      render json: @store
    end

    private

      def set_store
        @store = Store.find(params[:id])
      end
  end
end
