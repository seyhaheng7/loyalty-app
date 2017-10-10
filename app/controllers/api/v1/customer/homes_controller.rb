module Api::V1::Customer
  class HomesController < BaseController
    swagger_controller :homes, 'Homes'

    def self.add_common_params(api)
      api.param :for_page
    end

    swagger_api :index do
      summary 'Fetches all advertisements for home, reward, and store'
      response :unauthorized
      response :not_acceptable
    end

    def index

      @home_ads = Advertisement.active.for_page("Home")
      @stores = Store.limit(3)
      @rewards = Reward.available.limit(3)

      render json: {
        advertisements: @home_ads,
        stores: @stores,
        rewards: @rewards
      }, status: :ok

    end

  end
end
