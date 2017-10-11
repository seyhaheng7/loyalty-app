module Api::V1::Customer
  class AdvertisementsController < BaseController

    before_action :set_advertisement, only: [:show]

    swagger_controller :advertisements, 'Advertisements'

    def self.add_common_params(api)
      api.param :for_page
    end

    swagger_api :index do
      summary 'Fetches all advertisements'
      param :query, :for_page, :string, :optional, "['Home', 'Shop & Earn', 'Category detail', 'Rewards', 'Snap']"
      response :unauthorized
      response :not_acceptable
    end

    swagger_api :show do
      summary 'Get a advertisement'
      notes 'get information of advertisement by passing his advertisement id'
      param :path, :id, :integer, :required, 'ID of Advertisement'
      response :ok
      response :not_found
    end

    def index
      @advertisements = Advertisement.active.filter(params)
      render json: @advertisements, status: :ok
    end

    def show
      render json: @advertisement
    end

    private

      def set_advertisement
        @advertisement = Advertisement.find(params[:id])
      end
  end
end
