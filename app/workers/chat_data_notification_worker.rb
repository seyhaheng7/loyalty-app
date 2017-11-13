class ChatDataNotificationWorker
  include Sidekiq::Worker

  def perform(chat_datum_id)
    chat_datum  = ChatDatum.find chat_datum_id
    current_customer = chat_datum.customer
    chat_room   = chat_datum.chat_room
    members     = chat_room.chat_members.where.not(customer: current_customer, streaming: false).map(&:customer)
    push_notification(chat_data, members, current_customer, chat_room)
  end

  def push_notification(chat_datum, members, current_customer, chat_room)
    members.each do |member|
      notifyable = notification.notifyable
      app_id  = ENV['ONE_SIGNAL_APP_ID']
      app_key = ENV['ONE_SIGNAL_APP_KEY']

      content = if chat_datum.text?
                  chat_datum.text
                elsif chat_datum.sticker?
                  "#{current_customer.name} sent you a sticker"
                elsif chat_datum.audio?
                  "#{current_customer.name} sent you a voice message"
                end

      paramsnotification = {
        "app_id" => app_id,
        "contents" => {"en" => content,
        "include_player_ids" => member.devices.pluck(:device_id),
        "data" => {
          "type" => 'CustomerChatCustomer',
          "chat_room_id" => chat_room.id
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
