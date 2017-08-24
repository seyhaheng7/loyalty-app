class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Pundit
  
  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_url, alert: "You can't access to this page"
  end
end
