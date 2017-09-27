module Api::V1::Customer
  class GuidesController < BaseController
    before_action :set_guide, only: [:show]

    swagger_controller :guides, 'Guides'


    swagger_api :index do
      summary 'Fetches all guides'
      response :unauthorized
      response :not_acceptable
    end

    swagger_api :show do
      summary 'Get a guide'
      notes 'get information of guide by passing his guide id'
      param :path, :id, :integer, :required, 'ID of Guide'
      response :ok
      response :not_found
    end

    def index
      @guides = Guide.all
      render json: @guides, status: :ok
    end

    def show
      render json: @guide
    end

    private

      def set_guide
        @guide = Guide.find(params[:id])
      end

  end
end
