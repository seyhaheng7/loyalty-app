describe 'promotions' do
  let!(:customer){ create(:customer) }
  let!(:promotion){ create(:promotion) }
  let!(:promotion_inactive){ build(:promotion, start_date: '2017-10-01', end_date: '2017-10-01').tap{ |p| p.save(validate: false) }}
  let!(:promotions){ create_list(:promotion, 10) }

  describe 'GET api/v1/customer/promotions' do
    before do
      get api_v1_customer_promotions_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'include promotion' do
      json = JSON.parse(response.body)
      titles = json.map{ |j| j['title'] }
      expect(titles).to include promotion.title
    end

    it 'has pagination' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(11)
    end

    it 'return active promotion' do
      expect(Date.today).to be_between(promotion.start_date, promotion.end_date)
    end

    it 'does not return inactive promotion' do
      expect(Date.today).not_to be_between(promotion_inactive.start_date, promotion_inactive.end_date)
    end

  end
  describe 'GET api/v1/customer/promotions/:id' do
    before do
      get api_v1_customer_promotions_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return promotion' do
      json = JSON.parse(response.body)
      title = json['title'.to_i]
      expect(title.to_s).to include promotion.title
    end
  end

end
