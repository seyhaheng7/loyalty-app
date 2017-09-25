describe 'stores' do
  let!(:customer){ create(:customer) }
  let!(:video_ad){ create(:video_ad) }
  let!(:video_ads){ create_list(:video_ad, 10) }

  describe 'GET api/v1/customer/video_ads' do
    before do
      get api_v1_customer_video_ads_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end
    
    it 'include video_ad' do
      json = JSON.parse(response.body)
      titles = json.map{ |j| j['title'] }
      expect(titles).to include video_ad.title
    end

    it 'has pagination' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(11)
    end

  end
  describe 'GET api/v1/customer/video_ads/:id' do
    before do
      get api_v1_customer_video_ads_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return video_ad' do
      json = JSON.parse(response.body)
      title = json['title'.to_i]
      expect(title.to_s).to include video_ad.title
      # title.should include video_ad.title
    end
  end

end