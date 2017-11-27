class ReportsController < ApplicationController
  def rewards
    authorize :report
    @grid = ReportRewardGrid.new(params[:report_reward_grid])
    respond_to do |f|
      f.html do
        @grid.scope {|scope| scope.page(params[:page]) }
      end
      f.csv do
        send_data @grid.to_csv,
          type: "text/csv",
          disposition: 'inline',
          filename: "grid-#{Time.now.to_s}.csv"
      end
    end
  end

  def video_ads
    authorize :report
    @grid = ReportVideoAdsGrid.new(params[:report_video_ads_grid])
    respond_to do |f|
      f.html do
        @grid.scope {|scope| scope.page(params[:page]) }
      end
      f.csv do
        send_data @grid.to_csv,
          type: "text/csv",
          disposition: 'inline',
          filename: "grid-#{Time.now.to_s}.csv"
      end
    end

  end

  def ads
    authorize :report
    @grid = ReportAdsGrid.new(params[:report_ads_grid])
    respond_to do |f|
      f.html do
        @grid.scope {|scope| scope.page(params[:page]) }
      end
      f.csv do
        send_data @grid.to_csv,
          type: "text/csv",
          disposition: 'inline',
          filename: "grid-#{Time.now.to_s}.csv"
      end
    end
  end

  def customer_log
    authorize :report
    @grid = CustomerLogGrid.new(params[:customer_log_grid]) do |scope|
      scope.page(params[:page])
    end
  end
end
