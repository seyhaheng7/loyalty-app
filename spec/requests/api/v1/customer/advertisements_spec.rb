describe 'Advertisements' do
  let!(:customer){ create(:customer) }
  let!(:advertisement_inactive){ create(:advertisement, start_date: '2017-09-25', end_date: '2017-09-25') }
  let!(:advertisement){create(:advertisement)}
  let!(:advertisements){ create_list(:advertisement, 10)}
  describe 'GET api/v1/customer/advertisements' do
    before do
      get api_v1_customer_advertisements_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'has pagination' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(11)
    end

    it 'return active advertisement' do
      expect(Date.today).to be_between(advertisement.start_date, advertisement.end_date)
    end

    it 'does not return inactive advertisement' do
      expect(Date.today).not_to be_between(advertisement_inactive.start_date, advertisement_inactive.end_date)
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
