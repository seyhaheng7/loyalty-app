module Api::V1::Customer
  class ChatRoomsController < BaseController
    swagger_controller :chat_rooms, 'ChatRooms'

    def self.add_common_params(api)
      api.param :form, 'chat_room[customer][id]', :integer, :required, 'Customer ID to recieved the message'
    end

    swagger_api :index do
      summary 'Fetches all current customer chat rooms'
      response :unauthorized
      response :not_acceptable
    end

    swagger_api :create do |api|
      summary 'create a chat room'
      notes 'make sure you pass parameters in chat room'
      Api::V1::Customer::ChatRoomsController::add_common_params(api)
      response :ok
    end

    def index
      @chat_rooms = current_customer.chat_rooms
      render json: @chat_rooms
    end

    def create
      member = Customer.find params[:customer_id]
      chat_room = ChatRoom.member(current_customer.id).member(member.id).first
      if chat_room.blank?
        chat_room = current_customer.chat_rooms.create
        chat_room.chat_members.create(customer_id: params[:customer_id])
      end
      render json: chat_room
    end

  end
end
