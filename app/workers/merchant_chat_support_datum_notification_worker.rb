class MerchantChatSupportDatumNotificationWorker
  include Sidekiq::Worker

  def perform(merchant_chat_support_datum_id)
    merchant_chat_support_datum  = MerchantChatSupportDatum.find merchant_chat_support_datum_id
    merchant_chat_support        = merchant_chat_support_datum.merchant_chat_support
    supportable                  = merchant_chat_support_datum.supportable

    if supportable.class == User
      need_notify = !merchant_chat_support.merchant_streaming?
    else
      need_notify = !merchant_chat_support.admin_streaming?
    end

    if need_notify
      if supportable.class == User
        # Notify Merchant
        app_id = ENV['ONE_SIGNAL_MERCHANT_APP_ID']
        app_key = ENV['ONE_SIGNAL_MERCHANT_APP_KEY']
        merchant = merchant_chat_support.merchant
        device_ids = merchant.devices.pluck(:device_id)
        content = "Supporter send you a message"
      else
        # Notify Admin
        app_id = ENV['ONE_SIGNAL_APP_ID']
        app_key = ENV['ONE_SIGNAL_APP_KEY']
        device_ids = User.admin.includes(:devices).map{ |user| user.devices.map(&:device_id) }.flatten
        content = "Merchant send you a message"
      end


      paramsnotification = {
        "app_id" => app_id,
        "contents" => {"en" => content},
        "include_player_ids" => device_ids,
        "data" => {
          "type" => 'MerchantChatSupport',
          "chat_room_id" => merchant_chat_support.id
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
