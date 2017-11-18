class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_url, alert: "You can't access to this page"
  end

  protect_from_forgery with: :exception

  before_action :check_access_country!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  # before_action :authenticate_customer!, if: :customer_api?

  # trick to make devise token auth work
  skip_before_action :verify_authenticity_token, if: :devise_token_controller?
  skip_before_action :authenticate_user!, if: :devise_token_controller?

  layout :set_layout


  # restrict access to admin module for non-admin users
  def authenticate_admin_user!
    raise SecurityError unless current_user.try(:admin?)
  end

  rescue_from SecurityError do |exception|
    redirect_to root_url
  end

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
  def check_access_country!
    if !Rails.env.development? && ENV['RESTRICT_ACCESS'] == 'true'
      country = GEOIP.country(request.remote_ip)
      if country.country_name != 'Cambodia'
        render plain: 'Restrict Access from your country', status: 401
      end
    end
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :device_id ])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :phone, :registration, :first_name, :last_name, :gender, :avatar, :address, :lat, :long ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :phone, :gender, :name, :first_name, :last_name, :avatar, :address, :lat, :long, :password])
  end

end
