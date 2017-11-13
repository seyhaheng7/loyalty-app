class CustomerChatSupportDatumNotificationWorker
  include Sidekiq::Worker

  def perform(customer_chat_support_datum_id)
    customer_chat_support_datum  = CustomerChatSupportDatum.find customer_chat_support_datum_id
    customer_chat_support        = customer_chat_support_datum.customer_chat_support
    supportable                  = customer_chat_support_datum.supportable

    if supportable.class == User
      need_notify = !customer_chat_support.customer_streaming?
    else
      need_notify = !customer_chat_support.admin_streaming?
    end

    if need_notify
      app_id = ENV['ONE_SIGNAL_APP_ID']
      app_key = ENV['ONE_SIGNAL_APP_KEY']

      if supportable.class == User
        # Notify Customer
        customer = customer_chat_support.customer
        device_ids = customer.devices.pluck(:device_id)
        content = "Supporter send you a message"
      else
        # Notify Admin
        device_ids = User.admin.includes(:devices).map{ |user| user.devices.map(&:device_id) }.flatten
        content = "#{supportable.name} send you a message"
      end


      paramsnotification = {
        "app_id" => app_id,
        "contents" => {"en" => content},
        "include_player_ids" => device_ids,
        "data" => {
          "type" => 'CustomerChatSupport',
          "chat_room_id" => customer_chat_support.id
        }
      }

      uri = URI.parse('https://onesignal.com/api/v1/notifications')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.path,
                                    'Content-Type'  => 'application/json;charset=utf-8',
                                    'Authorization' => "Basic #{app_key}")

      request.body = paramsnotification.as_json.to_json
      response = http.request(request)

    end
  end
end
