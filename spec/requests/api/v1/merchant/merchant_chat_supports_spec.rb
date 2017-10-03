describe 'MerchantChatSupport' do
  let!(:merchant){ create(:merchant) }
  let!(:merchant_chat_support){ create(:merchant_chat_support, merchant: merchant) }

  describe 'GET api/v1/merchant/merchant_chat_supports' do
    before do
      get api_v1_merchant_merchant_chat_supports_path, headers: merchant.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return owner merchant chat support' do
      json = JSON.parse(response.body)
      expect(json['merchant']['id']).to eq merchant.id
    end

  end

end
