module Api::V1::Customer
  class StickerGroupsController < BaseController
    before_action :set_sticker_group, only: [:show, :update, :destroy]

    swagger_controller :sticker_groups, 'StickerGroups'

    swagger_api :index do
      summary 'Fetches all sticker_groups'
      param :query, :page, :integer, :optional, "Page number"
      response :unauthorized
      response :not_acceptable
    end

    swagger_api :show do
      summary 'Get a sticker_group'
      notes 'get information of sticker_group by passing his sticker_group id'
      param :path, :id, :integer, :required, 'ID of StickerGroup'
      response :ok
      response :not_found
    end

    def index
      @sticker_groups = StickerGroup.all.page(params[:page])
      render json: @sticker_groups, status: :ok
    end

    def show
      render json: @sticker_group
    end
    private

      def set_sticker_group
        @sticker_group = StickerGroup.find(params[:id])
      end

  end
end
