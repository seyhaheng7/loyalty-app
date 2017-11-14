describe 'CustomerChatSupportDatum' do
  let!(:customer){ create(:customer) }
  let!(:customer_chat_support_datum){ create(:customer_chat_support_datum, supportable: customer, customer_chat_support: customer.customer_chat_support) }
  let!(:customer_chat_support_data){ create_list(:customer_chat_support_datum, 10, supportable: customer, customer_chat_support: customer.customer_chat_support) }

  describe 'GET api/v1/customer/customer_chat_support_data' do
    before do
      get api_v1_customer_customer_chat_support_data_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return customer chat data' do
      json = JSON.parse(response.body)
      text = json.map{ |j| j['text'] }
      expect(text).to include customer_chat_support_datum.text
    end

    it 'has pagination' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(10)
    end

  end

end
