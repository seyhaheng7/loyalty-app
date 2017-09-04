describe 'Categories' do
  let!(:user){ create(:user) }
  let!(:categories){ create_list(:category, 10) }
  let!(:category){ create(:category) }
  describe 'GET api/v1/customer/categories' do
    before do
      get api_v1_customer_categories_path, headers: user.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'include category' do
      json = JSON.parse(response.body)
      names = json.map{ |j| j['name'] }
      expect(names).to include category.name
    end

    it 'has pagination' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(10)
    end
  end


  describe 'GET api/v1/customer/categories/:id' do
    before do
      get api_v1_customer_category_path(category), headers: user.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return category' do
      json = JSON.parse(response.body)
      name = json['name']
      expect(name).to include category.name
    end
  end
end