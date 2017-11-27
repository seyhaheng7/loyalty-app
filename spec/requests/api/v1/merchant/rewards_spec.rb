describe 'Reward' do
  let!(:store){ create(:store, name: "Codingate") }
  let!(:merchant){ create(:merchant, store: store) }

  context 'GET api/v1/merchant/rewards' do
    let!(:reward1){ create(:reward, name: "Car", require_points: 300, quantity: 6, store: store ) }
    let!(:reward2){ create(:reward, name: "Moto", require_points: 400, quantity: 6, store: store ) }
    let!(:reward3){ create(:reward, name: "Laptop", require_points: 500, quantity: 2, claimed_rewards_count: 2, store: store ) }

    before do
      get api_v1_merchant_rewards_path, headers: merchant.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'include available reward' do
      json  = JSON.parse(response.body)
      ids   = json.map{ |j| j['id'] }
      expect(ids).to include reward1.id
    end

    it 'include unavailable reward' do
      json  = JSON.parse(response.body)
      ids   = json.map{ |j| j['id'] }
      expect(ids).not_to include reward3.id
    end
  end

end
