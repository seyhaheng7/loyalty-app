class CustomerLocationsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: Customer.all }
     end
  end
end
