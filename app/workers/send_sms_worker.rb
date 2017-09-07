class SendSmsWorker
  include Sidekiq::Worker

  def perform(number, text_body)
    puts "send sms to #{number} with body #{text_body}"
    NEXMO_CLIENT.send_message(from: 'Customer Loyalty', to: number, text: text_body)
  end
end
