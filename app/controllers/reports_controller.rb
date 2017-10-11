class ReportsController < ApplicationController
  def rewards
    @grid = ReportRewardGrid.new(params[:report_reward_grid]) do |scope|
      scope.page(params[:page])
    end
    authorize @grid.assets
  end
end
