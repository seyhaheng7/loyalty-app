describe 'stores' do
  let!(:customer){ create(:customer) }
  let!(:notification){create(:notification)}

  describe 'GET api/v1/customer/notifications' do
    before do
      get api_v1_customer_notifications_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end
    
    it 'include video_ad' do
      json = JSON.parse(response.body)
      texts = json.map{ |j| j['text'] }
      expect(texts).to include notification.text
    end

  end

end