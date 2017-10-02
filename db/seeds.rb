ActiveRecord::Base.transaction do
  email = 'info@codingate.com'
  user = User.find_by email: email
  if user.present?
    user = User.new email: 'info@codingate.com', password: 'Codingate@2017', role: "Admin"
    user.save
  end
  User.create!(name: "Admin",email: "admin@example.com", password: "password", role: "Admin")

  5.times do |i|
    Category.create!(id: (i+1), name: FFaker::Name.name)
  end

  5.times do
    Company.create!(name: FFaker::Company.name, address: FFaker::Address.street_address, category_id: Random.rand(1..5))
  end

  5.times do
    Location.create!(name: FFaker::Address.city)
  end

  5.times do
    Store.create!(name: FFaker::Name.name, address: FFaker::Address.street_name, company_id: Random.rand(1..5), location_id: Random.rand(1..5))
  end

  5.times do
    Reward.create!(name: FFaker::Product.product_name, require_points: Random.rand(300..700), quantity: Random.rand(2..10), price: Random.rand(10**2), store_id: Random.rand(1..5), image: Rails.root.join("app/assets/images/default.png").open)
  end

  5.times do
    Merchant.create!(name: FFaker::Name.name, email: FFaker::Internet.email, phone: "1733#{Random.rand(50..99)}14", password: "password", store_id: Random.rand(1..5), avatar: Rails.root.join("app/assets/images/default.png").open)
  end

  5.times do
    Customer.create!(email: FFaker::Internet.email, phone: "1#{Random.rand(144..999)}9134", password: "password", current_points: Random.rand(800..900),verified_at: Time.now, avatar: Rails.root.join("app/assets/images/default.png").open)
  end



  5.times do
    status = ["approved", "rejected", "submitted"]
    Receipt.create!(receipt_id: FFaker::PhoneNumber.short_phone_number, earned_points: Random.rand(20..80), status: status.delete(status.sample), store_id: Random.rand(1..5), customer_id: Random.rand(1..5), total: Random.rand(100..500), capture: Rails.root.join("app/assets/images/default.png").open)
  end

  5.times do
    ClaimedReward.create!(customer_id: Random.rand(1..5), reward_id: Random.rand(1..5), status: status.delete(status.sample), qr_token: FFaker::Internet.domain_word)
  end

  5.times do
    Faq.create!(title: FFaker::Lorem.sentence , content: FFaker::Lorem.paragraph)
  end

  5.times do
    VideoAd.create!(title: FFaker::Lorem.sentence , start_date: Random.rand(5..15).days.ago, end_date: Random.rand(10..15).days.ago, earned_points: Random.rand(18..30) )
  end

  5.times do
    Advertisement.create!(name: FFaker::Name.name,  start_date: Random.rand(5..15).days.ago, end_date: Random.rand(10..15).days.ago, address: FFaker::Address.street_name, phone: "1#{Random.rand(144..999)}9134", banner: Rails.root.join("app/assets/images/default.png").open )
  end

  5.times do
    ContactForm.create!(subject: FFaker::Lorem.sentence , message: FFaker::Lorem.paragraph, customer_id: Random.rand(1..5))
  end

  50.times do
    platform = ["ios", "android", "window"]
    OperatingSystem.create!(name: platform.delete(platform.sample), customer_id: Random.rand(1..5))
  end
end
