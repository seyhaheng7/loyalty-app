describe 'Homes' do
  let!(:customer){ create(:customer) }
  let!(:advertisement){create(:advertisement, for_page: 'Home')}
  let!(:reward){create(:reward)}
  let!(:store){create(:store)}
  
  describe 'GET api/v1/customer/homes' do
    before do
      get api_v1_customer_homes_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return advertisements' do
      json = JSON.parse(response.body)
      advertisements = json['advertisements']
      advertisement_names = advertisements.map{ |j| j['name'] }
      expect(advertisement_names).to include advertisement.name
    end

    it 'return stores' do
      json = JSON.parse(response.body)
      stores = json['stores']
      store_names = stores.map{ |j| j['name'] }
      expect(store_names).to include store.name
    end

    it 'return rewards' do
      json = JSON.parse(response.body)
      rewards = json['rewards']
      reward_names = rewards.map{ |j| j['name'] }
      expect(reward_names).to include reward.name
    end

  end

end
