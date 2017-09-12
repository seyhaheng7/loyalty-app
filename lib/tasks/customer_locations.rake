namespace :customer_locations do
  desc "TODO"
  task update: :environment do
    5000.times do |i|
      sleep(Random.rand(5))
      customer = Customer.first(100).sample
      customer.update(lat: rand_lat, long: rand_long)
    end
  end

  def rand_lat
    11 + Random.new.rand(0.0000..0.5000)
  end
  
  def rand_long
    104 + Random.new.rand(0.0000..0.5000)
  end
end
