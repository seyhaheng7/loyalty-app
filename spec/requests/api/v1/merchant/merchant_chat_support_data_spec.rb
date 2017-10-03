describe 'MerchantChatSupportDatum' do
  let!(:merchant){ create(:merchant) }
  let!(:merchant_chat_support_datum){ create(:merchant_chat_support_datum, supportable: merchant, merchant_chat_support: merchant.merchant_chat_support) }
  let!(:merchant_chat_support_data){ create_list(:merchant_chat_support_datum, 10, supportable: merchant, merchant_chat_support: merchant.merchant_chat_support) }

  describe 'GET api/v1/merchant/merchant_chat_supports/:merchant_chat_support_id/merchant_chat_support_data' do
    before do
      get api_v1_merchant_merchant_chat_support_merchant_chat_support_data_path(merchant.merchant_chat_support), headers: merchant.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return merchant chat data' do
      json = JSON.parse(response.body)
      text = json.map{ |j| j['text'] }
      expect(text).to include merchant_chat_support_datum.text
    end

    it 'has pagination' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(10)
    end

  end

end
