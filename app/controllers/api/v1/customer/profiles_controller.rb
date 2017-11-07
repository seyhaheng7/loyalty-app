module Api::V1::Customer
  class ProfilesController < BaseController
    swagger_controller :profiles, 'Profiles'

    swagger_api :index do
      summary 'Fetches all user index'
      response :unauthorized
      response :not_acceptable
    end

    swagger_api :statistic do
      summary 'Fetches user statistic'
      param :query, :time, :string, :optional, '[this_month, last_month, before_last_month]'
      response :unauthorized
      response :not_acceptable
    end

    def index
      render json: :current_user, status: :ok
    end

    def statistic
      receipts = current_customer.receipts.time_filter(params[:time])
      total_expense = receipts.sum(:total)
      categories  = Category.all.map do |category|
        receipts_in_category = receipts.in_category(category.id)
        expense = receipts_in_category.sum(:total)
        category.as_json.merge(expense: expense)
      end
      render json: categories, status: :ok
    end

  end
end
