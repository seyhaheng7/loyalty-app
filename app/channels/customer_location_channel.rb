class CustomerLocationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "customer_location_channel"
  end

  def unsubscribed
  end
  
end
