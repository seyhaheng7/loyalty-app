describe 'Reward' do
  let!(:customer){ create(:customer) }

  context 'GET api/v1/customer/rewards' do
    let!(:store){ create(:store, name: "Codingate") }
    let!(:reward1){ create(:reward, :active, name: "google", require_points: 300, quantity: 6, store: store ) }
    let!(:reward2){ create(:reward, :active, name: "facebook", require_points: 500, quantity: 2, approved_claimed_rewards_count: 2, store: store ) }
    let!(:reward3){ create(:reward, :inactive, :available) }
    before do
      get api_v1_customer_rewards_path, headers: customer.create_new_auth_token
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
      expect(ids).not_to include reward2.id
    end

    it 'not include inactive reward' do
      json  = JSON.parse(response.body)
      ids   = json.map{ |j| j['id'] }
      expect(ids).not_to include reward3.id
    end
  end

  context 'GET api/v1/customer/rewards?store_name=store_name' do
    let!(:brown_store){ create(:store, name: "Brown Rain Tree") }
    let!(:kfc_store){ create(:store, name: "KFC BKK") }
    let!(:reward1){ create(:reward, :active,  store: brown_store ) }
    let!(:reward2){ create(:reward, :active, store: kfc_store ) }

    before do
      get api_v1_customer_rewards_path(store_name: "Brown"), headers: customer.create_new_auth_token
    end

    it 'include reward of store' do
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).to include reward1.id
    end

    it 'not include reward of other store' do
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).not_to include reward2.id
    end
  end


  context 'GET api/v1/customer/rewards?order_by=order_type' do
    let!(:reward1){ create(:reward, :active, require_points: 10, price: 20) }
    let!(:reward2){ create(:reward, :active, require_points: 30, price: 30) }
    let!(:reward3){ create(:reward, :active, require_points: 20, price: 10) }

    it 'order by newly added' do
      get api_v1_customer_rewards_path(order_by: 'newly added'), headers: customer.create_new_auth_token
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).to eq [reward3.id, reward2.id, reward1.id]
    end

    it 'order by low point' do
      get api_v1_customer_rewards_path(order_by: 'low point'), headers: customer.create_new_auth_token
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).to eq [reward1.id, reward3.id, reward2.id]
    end

    it 'order by hight point' do
      get api_v1_customer_rewards_path(order_by: 'hight point'), headers: customer.create_new_auth_token
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).to eq [reward2.id, reward3.id, reward1.id]
    end

    it 'order by vocher price' do
      get api_v1_customer_rewards_path(order_by: 'vocher price'), headers: customer.create_new_auth_token
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).to eq [reward2.id, reward1.id, reward3.id]
    end
  end

end
