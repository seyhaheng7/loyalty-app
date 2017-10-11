module Overrides::DeviseTokenAuth::Merchant
  class RegistrationsController < DeviseTokenAuth::RegistrationsController

    def create
    end


    protected

    # Trick to make token auth work start
    def authenticate_user!
      authenticate_merchant!
    end

    def current_user
      current_merchant
    end
    # Trick to make token auth work end


  end
end
