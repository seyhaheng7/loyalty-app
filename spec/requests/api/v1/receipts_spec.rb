describe 'Receipts' do
  let!(:user){ create(:user) }
  let!(:receipts){ create_list(:receipt, 10) }
  let!(:receipt){ create(:receipt) }

  describe 'GET  api/v1/receipts' do

    before do
      get api_v1_receipts_path, headers: user.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'include receipt' do
      json = JSON.parse(response.body)
      names = json.map{ |j| j['receipt_id'] }
      expect(names).to include receipt.receipt_id
    end

    it 'has pagination' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(10)
    end

  end

  describe 'GET api/v1/receipts/:id' do
    before do
      get api_v1_receipt_path(receipt), headers: user.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return receipt' do
      json = JSON.parse(response.body)
      name = json['receipt_id']
      expect(name).to include receipt.receipt_id
    end
  end

  describe 'POST api/v1/receipts' do

    let!(:store){  create(:store) }
    let!(:capture) { "data:image/png;base64,#{Base64.encode64(open('spec/support/default.png').read)}" }
    let!(:params1){ { receipt_id: '1234567',total: 21.213, capture: capture, store_id: store.id } }
    let!(:params2){ { receipt_id: '123456',total: 21.213, capture: capture, store_id: store.id } }
    let!(:receipt) { create(:receipt, params2) }

    before do
    end

    it 'return status successful' do
      post api_v1_receipts_path, headers: user.create_new_auth_token, params: { receipt: params1 } 
      expect(response).to have_http_status(201)
    end

    it 'errors when have duplicate receipts' do
      post api_v1_receipts_path, headers: user.create_new_auth_token, params: { receipt: params2 } 
      json = JSON.parse(response.body)
      expect(response).to have_http_status(422)    
      expect(json["errors"]["receipt_id"]).to include 'Receipt is already submitted'
    end
    
  end
end