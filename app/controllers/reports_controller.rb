class ReportsController < ApplicationController
  def rewards
    authorize :report
    @grid = ReportRewardGrid.new(params[:report_reward_grid]) do |scope|
      scope.page(params[:page])
    end
  end
  def ads
    @grid = ReportAdsGrid.new(params[:report_ads_grid]) do |scope|
      scope.page(params[:page])
    end
  end
end
