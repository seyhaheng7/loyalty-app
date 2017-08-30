class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_url, alert: "You can't access to this page"
  end
  before_action :configure_permitted_parameters, if: :devise_controller?


  protect_from_forgery with: :exception
  before_action :authenticate_user!

  # trick to make devise token auth work
  skip_before_action :verify_authenticity_token, if: :devise_token_controller?
  skip_before_action :authenticate_user!, if: :devise_token_controller?

  layout :set_layout
  private

  def devise_token_controller?
    params[:controller].split('/')[0] == 'devise_token_auth'
  end

  def set_layout
    devise_controller? ? 'devise' : 'application'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :phone, :registration ])
  end

end
