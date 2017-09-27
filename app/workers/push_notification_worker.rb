class PushNotificationWorker
  include Sidekiq::Worker

  def perform

    params = {"app_id" => ENV['ONE_SIGNAL_APP_ID'], 
        "contents" => {"en" => "English Message"},
        "include_player_ids" => notifyable.devices.pluck(:device_id)
      }
    uri = URI.parse('https://onesignal.com/api/v1/notifications')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path,
                                  'Content-Type'  => 'application/json;charset=utf-8',
                                  'Authorization' => "Basic #{ENV['ONE_SIGNAL_APP_KEY']}")
    
    request.body = params.as_json.to_json
    response = http.request(request)
  end

end
