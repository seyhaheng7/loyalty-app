describe 'Faqs' do
  let!(:customer){ create(:customer) }
  let!(:faq){ create(:faq) }
  let!(:faqs){ create_list(:faq, 10) }
  
  describe 'GET api/v1/customer/faqs' do
    before do
      get api_v1_customer_faqs_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'include faqs' do
      json  = JSON.parse(response.body)
      ids   = json.map{ |j| j['id'] }
      expect(ids).to include faq.id
    end

    it 'has pagination' do
      json = JSON.parse(response.body)
      expect(json.size).to eq(11)
    end

  end

  describe 'GET api/v1/customer/faqs/:id' do
    before do
      get api_v1_customer_faq_path(faq), headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return faq' do
      json = JSON.parse(response.body)
      id = json['id']
      expect(id).to eq faq.id
    end
  end

end