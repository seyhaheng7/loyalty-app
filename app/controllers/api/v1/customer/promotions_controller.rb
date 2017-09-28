module Api::V1::Customer
  class PromotionsController < BaseController
    before_action :set_promotion, only: [:show]

    swagger_controller :promotions, 'Promotions'

    swagger_api :index do
      summary 'Fetches all promotions'
      response :unauthorized
      response :not_acceptable
    end

    swagger_api :show do
      summary 'Get a promotion'
      notes 'get information of promotion by passing his promotion id'
      param :path, :id, :integer, :required, 'ID of Promotion'
      response :ok
      response :not_found
    end

    def index
      @promotions = Promotion.all
      render json: @promotions, status: :ok
    end

    def show
      render json: @promotion
    end

    private

      def set_promotion
        @promotion = Promotion.find(params[:id])
      end

  end
end
