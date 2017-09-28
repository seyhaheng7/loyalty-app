class PushNotificationWorker
  include Sidekiq::Worker

  def perform(notification_id)
    notification = Notification.find notification_id
    notifications_worker(notification)
    push_notification(notification)
  end

  private

  def notifications_worker(notification)
    sleep 1
    user = notification.notifyable
    ActionCable.server.broadcast "notifications_channel_#{user.id}", pending_notifications_count: user.pending_notifications_count
  end

  def push_notification(notification)
    notifyable = notification.notifyable
    paramsnotification = {"app_id" => ENV['ONE_SIGNAL_APP_ID'], 
        "contents" => {"en" => "#{notification.text}"},
        "include_player_ids" => notifyable.devices.pluck(:device_id)
      }
    uri = URI.parse('https://onesignal.com/api/v1/notifications')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path,
                                  'Content-Type'  => 'application/json;charset=utf-8',
                                  'Authorization' => "Basic #{ENV['ONE_SIGNAL_APP_KEY']}")
    
    request.body = paramsnotification.as_json.to_json
    response = http.request(request)
  end


end
