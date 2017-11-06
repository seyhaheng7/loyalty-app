class LandMarksController < ApplicationController
  before_action :set_land_mark, only: [:show]

  def index
    @grid = LandMarksGrid.new(params[:land_marks_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end

  def show
    authorize @land_mark

    @data = (Date.today-6..Date.today).map do |date|
      {
        date: date.strftime("%d %b"),
        visitors: @land_mark.customer_land_marks.in_date(date).count
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_land_mark
      @land_mark = LandMark.find(params[:id])
    end

end
