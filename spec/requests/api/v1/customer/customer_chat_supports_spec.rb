describe 'CustomerChatSupport' do
  let!(:customer){ create(:customer) }
  let!(:customer_chat_support){ create(:customer_chat_support, customer: customer) }

  describe 'GET api/v1/customer/customer_chat_supports' do
    before do
      get api_v1_customer_customer_chat_supports_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return owner merchant chat support' do
      json = JSON.parse(response.body)
      expect(json['customer']['id']).to eq customer.id
    end

  end

end
