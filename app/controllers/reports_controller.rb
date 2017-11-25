class ReportsController < ApplicationController
  def rewards
    authorize :report
    @grid = ReportRewardGrid.new(params[:report_reward_grid]) do |scope|
      scope.page(params[:page])
    end
  end

  def video_ads
    authorize :report
    @grid = ReportVideoAdsGrid.new(params[:report_video_ads_grid]) do |scope|
      scope.page(params[:page])
    end
  end

  def ads
    authorize :report
    @grid = ReportAdsGrid.new(params[:report_ads_grid]) do |scope|
      scope.page(params[:page])
    end
  end

  def customer_log
    authorize :report
    @grid = CustomerLogGrid.new(params[:customer_log_grid]) do |scope|
      scope.page(params[:page])
    end
  end
end
