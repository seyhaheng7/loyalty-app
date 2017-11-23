class SendSmsWorker
  include Sidekiq::Worker

  def perform(number, text_body)

    sms_log_text = "send sms to #{number} with body #{text_body}"
    puts sms_log_text
    sms_log_file = Rails.root.join('public', 'sms_logs.txt')
    if !Rails.env.production?
      open(sms_log_file, 'a') do |f|
        f << sms_log_text+"\n"
      end
    end

    username = ENV['SMS_USER']
    password = ENV['SMS_PASSWORD_MD5']
    if username.present? && password.present?
      sender   = ENV['SMS_SENDER']
      sms_url = "http://client.mekongsms.com/api/sendsms.aspx?username=#{username}&pass=#{password}&cd=besting&sender=#{sender}&isflash=0&smstext=#{text_body}&gsm=#{number}"

      puts sms_url
      url = URI.parse(sms_url)
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      puts res.body
    end

  end
end
