describe 'stores' do
  let!(:customer){ create(:customer) }
  let!(:stores){ create_list(:store, 10) }
  let!(:store){ create(:store) }

  describe 'GET api/v1/customer/stores' do
    before do
      get api_v1_customer_stores_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'include store' do
      json = JSON.parse(response.body)
      names = json.map{ |j| j['name'] }
      expect(names).to include store.name
    end

    it 'has pagination' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(10)
    end
  end

  describe 'GET api/v1/customer/stores?lat=lat&long=long' do
    let!(:store1){ create(:store, lat: 13.095730, long: 103.202205) }
    let!(:store2){ create(:store, lat: 13.082966, long: 103.145485) }
    before do
      get api_v1_customer_stores_path(lat: 13.095730, long: 103.20221), headers: customer.create_new_auth_token
    end

    it 'include nearby store' do
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).to include store1.id
    end

    it 'not include far away store' do
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).not_to include store2.id
    end
  end

  describe 'GET api/v1/customer/stores?category_id=category_id' do
    let!(:category1){  create(:category) }
    let!(:company1){ create(:company, category: category1) }
    let!(:store1){create(:store, company: company1)}
    let!(:store2){create(:store)}

    before do
      get api_v1_customer_stores_path(category_id: category1.id), headers: customer.create_new_auth_token
    end

    it 'should return store of category' do
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).to include store1.id
    end

    it 'should not return store of other category' do
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).not_to include store2.id
    end
  end

  describe 'GET api/v1/stores?only_partners=true' do
    let!(:company1){ create(:company, partner: false) }
    let!(:company2){ create(:company, partner: true) }
    let!(:store1){ create(:store, company: company1) }
    let!(:store2){ create(:store, company: company2) }

    before do
      get api_v1_customer_stores_path(only_partners: true), headers: customer.create_new_auth_token
    end



    it "should not return store that have company partner false" do
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).not_to include store1.id
    end

  end


  describe 'GET api/v1/customer/stores/:id' do
    before do
      get api_v1_customer_store_path(store), headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return store' do
      json = JSON.parse(response.body)
      name = json['name']
      expect(name).to include store.name
    end
  end

end
