module Api::V1::Customer
  class FaqsController < BaseController
    
    before_action :set_faq, only: [:show]

    swagger_controller :faqs, 'FAQs'
    
    swagger_api :index do
      summary 'Fetches all faqs'
      response :unauthorized
      response :not_acceptable
    end

    swagger_api :show do
      summary 'Get a faq'
      notes 'get information of faq by passing his faq id'
      param :path, :id, :integer, :required, 'ID of Faq'
      response :ok
      response :not_found
    end

    def index
      @faqs = Faq.all
      render json: @faqs, status: :ok
    end

    def show
      render json: @faq
    end
    
    private

      def set_faq
        @faq = Faq.find(params[:id])
      end

  end
end