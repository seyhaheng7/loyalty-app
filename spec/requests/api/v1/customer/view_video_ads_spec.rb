describe 'view video ad' do
  let!(:customer){ create(:customer) }
  let!(:video_ad){create(:video_ad, earned_points: 10, max_view_per_day: 3)}

  describe 'POST api/v1/customer/view_video_ads' do
    let!(:params){ { view_video_ad: { video_ad_id: video_ad.id } } }

    before do
      post api_v1_customer_view_video_ads_path, headers: customer.create_new_auth_token, params: params
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'increase customer points' do
      increased_points = customer.current_points + 10
      customer.reload
      expect(customer.current_points).to eq increased_points
    end

    it 'increase view video ad' do
      view_video_ad = customer.view_video_ads.last
      expect(view_video_ad.view_count).to eq 1
    end

    it 'return status unprocessable when reach max view' do
      view_video_ad = customer.view_video_ads.last
      view_video_ad.update(view_count: 3)
      post api_v1_customer_view_video_ads_path, headers: customer.create_new_auth_token, params: params
      expect(response).to have_http_status(422)
    end

  end

end
