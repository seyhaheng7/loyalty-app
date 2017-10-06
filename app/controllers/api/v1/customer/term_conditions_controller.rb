module Api::V1::Customer
  class TermConditionsController < BaseController

    swagger_controller :term_condtions, 'Term Condtions'

    swagger_api :index do
      summary 'Get a term_condtions'
      notes 'get information of term_condtions by passing his term_condtions id'
      param :path, :id, :integer, :required, 'ID of Term Condtion'
      response :ok
      response :not_found
    end

    def index
      @term_condtion = TermCondition.first_or_create
      render json: @term_condtion
    end
  end
end
