class UpdateCustomerLocationWorker
  include Sidekiq::Worker

  def perform(customer_id)
    customer = Customer.find customer_id
    ActionCable.server.broadcast "customer_location_channel", customer: customer
  end
end
