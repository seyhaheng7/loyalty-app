describe 'Profiles' do
  let!(:customer){ create(:customer) }
  describe 'GET api/v1/profiles' do
    it 'return status successful' do
      get api_v1_customer_profiles_path, headers: customer.create_new_auth_token
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET api/v1/profiles/statistic' do
    let!(:category1){ create(:category) }
    let!(:category2){ create(:category) }
    let!(:company1){ create(:company, category: category1) }
    let!(:company2){ create(:company, category: category1) }
    let!(:company3){ create(:company, category: category2) }
    let!(:company4){ create(:company, category: category2) }
    let!(:store1){ create(:store, company: company1) }
    let!(:store2){ create(:store, company: company2) }
    let!(:store3){ create(:store, company: company3) }
    let!(:store4){ create(:store, company: company4) }
    let!(:receipt1){ create(:receipt, total: 10, store: store1, customer: customer) }
    let!(:receipt2){ create(:receipt, total: 20, store: store2, customer: customer) }
    let!(:receipt3){ create(:receipt, total: 30, store: store3, customer: customer) }
    let!(:receipt4){ create(:receipt, total: 40, store: store4, customer: customer) }

    it 'return status successful' do
      get statistic_api_v1_customer_profiles_path, headers: customer.create_new_auth_token
      json = JSON.parse(response.body)
      category1_statistic = json.select{ |category| category['id'] == category1.id }.first
      category2_statistic = json.select{ |category| category['id'] == category2.id }.first
      expect(category1_statistic['expense']).to eq(30)
      expect(category2_statistic['expense']).to eq(70)
    end
  end
end
