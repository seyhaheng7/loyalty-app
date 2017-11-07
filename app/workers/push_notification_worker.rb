class PushNotificationWorker
  include Sidekiq::Worker
  include Rails.application.routes.url_helpers
  sidekiq_options queue: 'notification'

  def perform(notification_id)
    notification = Notification.find notification_id

    if notification.notifyable_type == 'User'
      notifications_worker(notification)
    end

    push_notification(notification)

  end

  private

  def notifications_worker(notification)
    user = notification.notifyable
    ActionCable.server.broadcast "notifications_channel_#{user.id}", pending_notifications_count: user.pending_notifications_count
  end

  def push_notification(notification)
    sleep 1
    notifyable = notification.notifyable
    APP_ID =  if notifyable.class == Merchant
                ENV['ONE_SIGNAL_MERCHANT_APP_ID']
              else
                ENV['ONE_SIGNAL_MERCHANT_APP_ID']
              end

    APP_KEY = if notifyable.class == Merchant
                ENV['ONE_SIGNAL_APP_KEY']
              else
                ENV['ONE_SIGNAL_APP_ID']
              end

    paramsnotification = {
      "app_id" => APP_ID,
      "contents" => {"en" => "#{notification.text}"},
      "include_player_ids" => notifyable.devices.pluck(:device_id),
      "data" => {
        "type" => notification.notification_type,
        "id" => notification.notifyable_id
      }
    }

    if notification.notification_type == 'NewPromotion'
      promotion = notification.objectable
      paramsnotification['big_picture'] = promotion.image.url
    end

    if notification.notifyable_type == 'User'
      paramsnotification['url'] = path_for_notification(notification)
    end


    uri = URI.parse('https://onesignal.com/api/v1/notifications')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path,
                                  'Content-Type'  => 'application/json;charset=utf-8',
                                  'Authorization' => "Basic #{APP_KEY}")

    request.body = paramsnotification.as_json.to_json
    response = http.request(request)
  end

  def path_for_notification(notification)
    type = notification.notification_type
    object = notification.objectable_id

    case type

    when 'SubmittedReceipt'
      receipt_path(object)
    when 'SubmittedClaimedReward'
      claimed_reward_path(object)
    else
      raise "Unknown type"
    end

  end

end
