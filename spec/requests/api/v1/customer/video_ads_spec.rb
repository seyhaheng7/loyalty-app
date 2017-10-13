describe 'video ad' do
  let!(:customer){ create(:customer) }
  let!(:video_ad){ create(:video_ad) }

  let!(:inactive_video_ad){ create(:video_ad, start_date: Date.today+10, end_date: Date.today + 20.days) }
  let!(:max_video_ad){ create(:video_ad, max_view_per_day: 1) }
  let!(:max_view_video_ad){ create(:view_video_ad, customer: customer, video_ad: max_video_ad, view_count: 1, date: Date.today) }
  let!(:video_ads){ create_list(:video_ad, 10) }

  describe 'GET api/v1/customer/video_ads' do
    before do
      get api_v1_customer_video_ads_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'include active video_ad' do
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).to include video_ad.id
    end

    it 'has pagination' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(10)
    end

    it 'not include inactive video_ad' do
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).not_to include inactive_video_ad.id
    end

    it 'not include video that reach max views' do
      json = JSON.parse(response.body)
      ids = json.map{ |j| j['id'] }
      expect(ids).not_to include max_video_ad.id
    end

  end

  describe 'GET api/v1/customer/video_ads/:id' do
    before do
      get api_v1_customer_video_ad_path(video_ad), headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return video_ad' do
      json = JSON.parse(response.body)
      title = json['title']
      expect(title).to include video_ad.title
    end
  end

  describe 'Get api/v1/customer/video_ads?' do

    it 'return list of asc' do

      VideoAd.destroy_all
      create(:video_ad, title: 'ABC')
      create(:video_ad, title: 'BCA')
      get api_v1_customer_video_ads_path(order: { title: 'asc' }), headers: customer.create_new_auth_token

      json = JSON.parse(response.body)
      titles = json.map{ |j| j['title'] }
      expect(titles).to eq ['ABC', 'BCA']
    end

    it 'return list of desc' do

      VideoAd.destroy_all
      create(:video_ad, title: 'ABC')
      create(:video_ad, title: 'BCA')
      get api_v1_customer_video_ads_path(order: { title: 'desc' }), headers: customer.create_new_auth_token

      json = JSON.parse(response.body)
      titles = json.map{ |j| j['title'] }
      expect(titles).to eq ['BCA', 'ABC']
    end

  end

end
