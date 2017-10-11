module Api::V1::Customer
  class ChatDataController < BaseController
    swagger_controller :chat_data, 'ChatData'

    swagger_api :index do
      summary 'Fetches all customer chat data'
      param :path, :chat_room_id, :integer, :required, "ID of chat room"
      param :query, :page, :integer, :optional, "Page number"
      response :unauthorized
      response :success
      response :not_acceptable, "The request you made is not acceptable"
      response :requested_range_not_satisfiable
    end

    def index
      chat_room = current_customer.chat_rooms.find(params[:chat_room_id])
      @chat_data = chat_room.chat_data.page(params[:page]).includes(:customer)
      render json: @chat_data
    end

  end
end
