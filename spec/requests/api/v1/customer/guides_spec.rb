describe 'guides' do
  let!(:customer){ create(:customer) }
  let!(:guide){ create(:guide) }
  let!(:guides){ create_list(:guide, 10) }

  describe 'GET api/v1/customer/guides' do
    before do
      get api_v1_customer_guides_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end
    
    it 'include guide' do
      json = JSON.parse(response.body)
      titles = json.map{ |j| j['title'] }
      expect(titles).to include guide.title
    end

    it 'has pagination' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(11)
    end

  end
  describe 'GET api/v1/customer/guides/:id' do
    before do
      get api_v1_customer_guides_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return guide' do
      json = JSON.parse(response.body)
      title = json['title'.to_i]
      expect(title.to_s).to include guide.title
      # title.should include video_ad.title
    end
  end

end