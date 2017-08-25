class ApplicationController < ActionController::Base
  # include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_url, alert: "You can't access to this page"
  end

  protect_from_forgery with: :exception
  before_action :authenticate_user!

  layout :set_layout
  private

  def set_layout
    devise_controller? ? 'devise' : 'application'
  end

end
