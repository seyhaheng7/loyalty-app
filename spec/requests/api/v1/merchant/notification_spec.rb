describe 'notification' do

  let!(:merchant){ create(:merchant) }
  let!(:notification){create(:notification, notifyable: merchant)}
  describe 'GET api/v1/merchant/notifications' do
    before do
      get api_v1_merchant_notifications_path, headers: merchant.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'include customer notification' do
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).to include notification.id
    end
  end

end
