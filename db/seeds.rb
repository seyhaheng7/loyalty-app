ActiveRecord::Base.transaction do
  email = 'info@codingate.com'
  user = User.find_by email: email
  if user.present?
    user = User.new email: 'info@codingate.com', password: 'Codingate@2017', role: "Admin"
    user.save
  end
  User.create!(name: "Admin",email: "admin@example.com", password: "password", role: "Admin")

  2.times do
    User.create!(name: FFaker::Name.name, email: FFaker::Internet.email, password: "password", role: "Approver")
  end

  2.times do
    User.create!(name: FFaker::Name.name, email: FFaker::Internet.email, password: "password", role: "Receptionist")
  end

  10.times do |i|
    Category.create!(name: FFaker::Name.name)
  end

  20.times do
    Faq.create!(title: FFaker::Lorem.sentence , content: FFaker::Lorem.paragraph)
  end

  20.times do
    Guide.create!(title: FFaker::Book.title, youtube_url: FFaker::Youtube.video_id)
  end

  
  # 3 Advertisements per page
  
  3.times do
    Advertisement.create!(name: FFaker::Name.name, banner: Rails.root.join("vendor/assets/images/admin/a1.jpg").open, for_page: "Home", address: FFaker::Address, phone: "1#{Random.rand(144..999)}9134", website: FFaker::Internet.http_url, start_date: Random.rand(5..15).days.ago, end_date: Random.rand(10..15).days.ago)
  end

  3.times do
    Advertisement.create!(name: FFaker::Name.name, banner: Rails.root.join("vendor/assets/images/admin/a2.jpg").open, for_page: "Shop & Earn", address: FFaker::Address, phone: "1#{Random.rand(144..999)}9134", website: FFaker::Internet.http_url, start_date: Random.rand(5..15).days.ago, end_date: Random.rand(10..15).days.ago)
  end

  3.times do
    Advertisement.create!(name: FFaker::Name.name, banner: Rails.root.join("vendor/assets/images/admin/a3.jpg").open, for_page: "Category detail", address: FFaker::Address, phone: "1#{Random.rand(144..999)}9134", website: FFaker::Internet.http_url, start_date: Random.rand(5..15).days.ago, end_date: Random.rand(10..15).days.ago)
  end

  3.times do
    Advertisement.create!(name: FFaker::Name.name, banner: Rails.root.join("vendor/assets/images/admin/a4.jpg").open, for_page: "Rewards", address: FFaker::Address, phone: "1#{Random.rand(144..999)}9134", website: FFaker::Internet.http_url, start_date: Random.rand(5..15).days.ago, end_date: Random.rand(10..15).days.ago)
  end

  3.times do
    Advertisement.create!(name: FFaker::Name.name, banner: Rails.root.join("vendor/assets/images/admin/a5.jpg").open, for_page: "Snap", address: FFaker::Address, phone: "1#{Random.rand(144..999)}9134", website: FFaker::Internet.http_url, start_date: Random.rand(5..15).days.ago, end_date: Random.rand(10..15).days.ago)
  end

  50.times do
    images = ["r6.jpg", "r7.png", "r8.png"]
    Reward.create!(name: FFaker::Name.name, image: Rails.root.join("vendor/assets/images/admin/#{images.delete(images.sample)}").open, require_points: Random.rand(1..5) , quantity: Random.rand(10..30) , price: Random.rand(2..10))
  end

  5.times do
    Location.create!(name: FFaker::Address.city)
  end


  # create customers 
  6000.times do
    email       = FFaker::Internet.email
    phone       = "#{Random.rand(1000..3000)}#{Random.rand(3000..9000)}"
    password    = "password"
    current_points    = Random.rand(800..900)
    verified_at = Time.now
    avatar_file = ["d1.png", "d2.png", "d3.jpg"]
    avatar      = Rails.root.join("vendor/assets/images/admin/#{avatar_file.delete(avatar_file.sample)}").open

    platform = ["ios", "android", "window"]
    operating_system_name        = platform.delete(platform.sample)
    
    status = ["approved", "rejected", "submitted"]
    receipt_id   = FFaker::PhoneNumber.short_phone_number
    earned_points = Random.rand(20..80)
    receipt_status =status.delete(status.sample)
    store_id =Random.rand(1..5)
    total = Random.rand(100..500)

    capture_image = ["r1.jpg", "r2.jpg", "r3.png", "r4.jpg"]
    capture = Rails.root.join("vendor/assets/images/admin/#{capture_image.delete(capture_image.sample)}").open

    reward_id = Random.rand(1..50)
    claimed_reward_status = status.delete(status.sample)
    qr_token = FFaker::Internet.domain_word
    given = ["true", "false"]

    customer = Customer.create!(
      email:              email,
      phone:              phone,
      password:           password, 
      current_points:     current_points,
      verified_at:        verified_at,
      avatar:             avatar,
    )
    
    customer.operating_systems.create(
      name: operating_system_name,
      customer: customer[rand(1..6000)]
    )

    customer.receipts.create(
      receipt_id:  receipt_id,
      earned_points:  earned_points,
      status:  receipt_status,
      store_id: store_id,
      total:  total,
      capture: capture,
      customer: customer[rand(1..100)]
    )

    customer.claimed_rewards.create(
      reward_id: reward_id, 
      status: claimed_reward_status, 
      given: given,
      qr_token: qr_token,
      customer: customer[rand(1..50)],
    )

  end

  50.times do
    company_name = FFaker::Name.name
    file = ["l1.png", "l2.jpg", "l3.jpg"]
    images = Rails.root.join("vendor/assets/images/admin/#{file.delete(file.sample)}").open
    address = FFaker::Address.street_address
    
    store_name = FFaker::Name.name
    reward_name = FFaker::Name.name
    require_points = Random.rand(300..700)
    quantity = Random.rand(2..10)
    price = Random.rand(10**2)

    company = Company.create(
      name: company_name,
      logo: images,
      address: address,
      category_id: Random.rand(1..5),

    )
    
    store = company.stores.create(
      name: store_name, 
      address: address, 
      company: company[rand(1..10)],
      location_id: Random.rand(1..5),
    )

    store.rewards.create(
      name: reward_name, 
      require_points: require_points, 
      quantity: quantity, 
      price: price, 
      store: store[rand()],
      image: images,
    )

  end

end
