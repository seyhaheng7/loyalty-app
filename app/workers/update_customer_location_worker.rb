class UpdateCustomerLocationWorker
  include Sidekiq::Worker

  def perform(customer_id)
    customer = Customer.find customer_id
    ActionCable.server.broadcast "customer_location_channel", customer: customer
    add_customer_location_history(customer)
  end


  def add_customer_location_history(customer)
    lat = customer.lat
    long = customer.long
    customer_id = customer.id
    land_marks = Geocoder.search("#{lat},#{long}")
    if land_marks.present?
      land_mark = land_marks.select{ |lm| lm.types.include?('neighborhood') }.first
      if land_mark.blank?
        land_mark = land_marks.first
      end
      land_mark_name = land_mark.formatted_address
      land_mark = LandMark.first_or_create(name: land_mark_name)
      customer_land_marks = CustomerLandMark.where(customer_id: customer_id, land_mark: land_mark).today
      if customer_land_marks.blank?
        CustomerLandMark.create(customer_id: customer_id, lat: lat, long: long, land_mark: land_mark)
      end
    end
  end
end
