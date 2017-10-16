module Api::V1::Customer
  class VoiceMessagesController < BaseController
    before_action :set_voice_message, only: [:show]

    swagger_controller :voice_messages, 'Voice Messages'

    def self.add_common_params(api)
      api.param :form, 'voice_message[voice_file]', :string, :required, 'Voice File'
    end

    swagger_api :show do
      summary 'Get a Voice Message'
      notes 'get information of voice_messages by passing his voice_message id'
      param :path, :id, :integer, :required, 'ID of Voice Message'
      response :ok
      response :not_found
    end

    swagger_api :create do |api|
      summary 'create a voice_message'
      notes 'make sure you pass parameters in voice_message'
      Api::V1::Customer::VoiceMessagesController::add_common_params(api)
      response :ok
    end

    def show
      render json: @voice_message
    end

    def create
      @voice_message = VoiceMessage.new(voice_message_params)
      if @voice_message.save
        render json: @voice_message, status: :created
      else
        render json: @voice_message, status: :unprocessable_entity
      end
    end

    private

      def set_voice_message
        @voice_message = VoiceMessage.find(params[:id])
      end

      def voice_message_params
        params.require(:voice_message).permit(:voice_file)
      end
  end
end
