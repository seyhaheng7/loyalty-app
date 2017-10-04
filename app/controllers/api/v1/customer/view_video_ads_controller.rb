module Api::V1::Customer
  class ViewVideoAdsController < BaseController

    swagger_controller :view_video_ads, 'View_video_ads'

    def self.add_common_params(api)
      api.param :form, 'view_video_ad[video_ad_id]', :string, :require, 'video id'
    end

    swagger_api :index do
      summary 'Fetches all view_video_ads'
      response :unauthorized
      response :not_acceptable
    end

    swagger_api :create do |api|
      summary 'create a view_video_ad'
      notes 'make sure you pass parameters in view_video_ad'
      Api::V1::Customer::ViewVideoAdsController::add_common_params(api)
      response :ok
      response :unprocessable_entity
    end

    def index
      @view_video_ads = current_customer.view_video_ads
      render json: @view_video_ads, status: :ok
    end

    def create
      video_id        = view_video_ad_params[:video_ad_id]
      today_view_ads  = current_customer.view_video_ads.today
      view_video_ad   = today_view_ads.where(video_ad_id: video_id).first_or_create
      if view_video_ad.increase_views!
        render json: view_video_ad
      else
        render json: view_video_ad.errors, status: :unprocessable_entity
      end
    end

    private

      def view_video_ad_params
        params.require(:view_video_ad).permit(:video_ad_id)
      end
  end
end
