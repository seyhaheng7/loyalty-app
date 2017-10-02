describe 'notification' do
  
  let!(:customer){ create(:customer) }
  let!(:notification){create(:notification, notifyable: customer)}
  describe 'GET api/v1/customer/notifications' do
    before do
      get api_v1_customer_notifications_path, headers: customer.create_new_auth_token
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
