describe 'users' do

  let!(:customer1){ create(:customer, lat:13.094336 , long:103.205481) }
  let!(:customer2){ create(:customer, lat:13.093918 , long:103.205137) }
  let!(:customer3){ create(:customer, lat:13.100689 , long:103.236465) }
  let!(:customer4){ create(:customer) }

  describe 'GET api/v1/customer/near_by_customers' do

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    before do
      get api_v1_customer_near_by_customers_path, headers: customer1.create_new_auth_token
    end

    it 'not include self customer' do
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).not_to include customer1.id
    end


    it 'not include offline user' do
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).not_to include customer4.id
    end

    it 'include nearby User' do
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).to include customer2.id
    end

    it 'not include far away User' do
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).not_to include customer3.id
    end

  end

end
