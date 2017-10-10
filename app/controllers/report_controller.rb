class ReportController < ApplicationController
  def reward
    @grid = ReportRewardGrid.new(params[:report_reward_grid]) do |scope|
      scope.page(params[:page])
    end
  end
end
