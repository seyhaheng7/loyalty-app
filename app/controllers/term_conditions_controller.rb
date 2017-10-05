class TermConditionsController < ApplicationController
  before_action :set_term_condition, only: [:update]

  def index
    @term_condition = TermCondition.first_or_create
    authorize @term_condition
  end

  def update
    authorize @term_condition
    if @term_condition.update(term_condition_params)
      redirect_to term_conditions_path, notice: 'Privacy policy was successfully updated.'
    else
      render :index
    end
  end

  private
    def set_term_condition
      @term_condition = TermCondition.find(params[:id])
    end

    def term_condition_params
      params.require(:term_condition).permit(:body)
    end
end
