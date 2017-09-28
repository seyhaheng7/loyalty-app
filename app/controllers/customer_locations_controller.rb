class CustomerLocationsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: Customer.active }
    end
  end
end
