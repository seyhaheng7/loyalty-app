describe 'Customer' do
  let!(:customer){ create(:customer) }

  describe 'GET api/v1/customer/customers/profile' do
    before do
      get profile_api_v1_customer_customers_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return customer phone' do
      json = JSON.parse(response.body)
      phone = json['phone']
      expect(phone).to eq customer.phone
    end

  end

end