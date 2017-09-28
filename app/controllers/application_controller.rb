class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_url, alert: "You can't access to this page"
  end

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  # before_action :authenticate_customer!, if: :customer_api?

  # trick to make devise token auth work
  skip_before_action :verify_authenticity_token, if: :devise_token_controller?
  skip_before_action :authenticate_user!, if: :devise_token_controller?

  layout :set_layout
  private

  def api?
    params[:controller].include? 'api/v1'
  end

  def customer_api?
    params[:controller].include? 'api/v1/customer'
  end
  def merchant_api?
    params[:controller].include? 'api/v1/merchant'
  end

  def devise_token_controller?
    params[:controller].include? 'devise_token_auth'
  end

  def set_layout
    devise_controller? ? 'devise' : 'application'
  end

  protected

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :device_id ])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :phone, :registration ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :phone, :gender, :name, :avatar, :address, :lat, :long ])
  end

end
