class HomeController < ApplicationController
  def index
    @rewards = Reward.all.count
    @stores = Store.all.count
    @customers = Customer.all.count
    @onlines = Customer.active.count

    @statistic = Receipt.dashboard_statistic
  end
end
