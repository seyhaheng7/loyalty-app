describe 'Advertisements' do
  let!(:customer){ create(:customer) }
  let!(:advertisements){ create_list(:advertisement, 10) }
  let!(:advertisement){ create(:advertisement) }

  describe 'GET api/v1/customer/advertisements' do
    before do
      get api_v1_customer_advertisements_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'include advertisements' do
      json  = JSON.parse(response.body)
      ids   = json.map{ |j| j['id'] }
      expect(ids).to include advertisement.id
    end

    it 'has pagination' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(11)
    end

  end

  describe 'GET api/v1/customer/advertisements/:id' do
    before do
      get api_v1_customer_advertisement_path(advertisement), headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return advertisement' do
      json = JSON.parse(response.body)
      id = json['id']
      expect(id).to eq advertisement.id
    end
  end

end
