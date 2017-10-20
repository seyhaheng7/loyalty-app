describe 'Voice Messages' do
  let!(:customer){ create(:customer) }
  let!(:voice_message){ create(:voice_message) }

  describe 'GET api/v1/customer/voice_messages/:id' do
    before do
      get api_v1_customer_voice_message_path(voice_message), headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return voice message' do
      json = JSON.parse(response.body)
      voice_file = json['voice_file']['url']
      binding.pry
      expect(voice_file).to include voice_message.voice_file_url
    end

  end
end
