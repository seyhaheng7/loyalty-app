class SendSmsWorker
  include Sidekiq::Worker

  def perform(number, text_body)

    sms_log_text = "send sms to #{number} with body #{text_body}"
    puts sms_log_text
    sms_log_file = Rails.root.join('public', 'sms_logs.txt')
    open(sms_log_file, 'a') do |f|
      f << sms_log_text+"\n"
    end

    NEXMO_CLIENT.send_message(from: 'Customer Loyalty', to: number, text: text_body)
  end
end
