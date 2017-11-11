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

    swagger_api :create do |api|
      summary 'Create customer chat data (Channel: CustomerChatCustomerChannel)'
      api.param :form, 'data[text]', :string, :optional, 'Text'
      api.param :form, 'data[sticker]', :string, :optional, 'Sticker Url'
      api.param :form, 'data[audio]', :string, :optional, 'Audio Url'
      response :unauthorized
      response :success
      response :not_acceptable, "The request you made is not acceptable"
    end

    before_action :find_chat_room

    def index
      @chat_data = @chat_room.chat_data.page(params[:page]).includes(:customer)
      render json: @chat_data
    end

    def create
      @chat_data = @chat_room.chat_data.new(chat_datumn_params.merge(customer: current_customer))
      if @chat_data.save

        render json: @chat_data, status: :created
      else
        render json: @chat_data.errors, status: :unprocessable_entity
      end
    end

    private

    def find_chat_room
      @chat_room = current_customer.chat_rooms.find(params[:chat_room_id])
    end

    def chat_datumn_params
      params.require(:chat_datumn).permit(:text, :sticker, :audio)
    end
  end
end
