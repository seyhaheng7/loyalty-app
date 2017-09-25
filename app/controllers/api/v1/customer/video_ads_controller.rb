module Api::V1::Customer
  class VideoAdsController < BaseController
    before_action :set_video_ad, only: [:show]

    swagger_controller :video_ads, 'Video Ads'

     swagger_api :index do
      summary 'Fetches all video_ads'
      response :unauthorized
      response :not_acceptable
    end

    swagger_api :show do
      summary 'Get a video_ad'
      notes 'get information of video_ad by passing his video_ad id'
      param :path, :id, :integer, :required, 'ID of Video_ad'
      response :ok
      response :not_found
    end

    def index
      @video_ads = VideoAd.all
      render json: @video_ads, status: :ok
    end

    def show
      render json: @video_ad
    end

    private

      def set_video_ad
        @video_ad = VideoAd.find(params[:id])
      end
  end
end