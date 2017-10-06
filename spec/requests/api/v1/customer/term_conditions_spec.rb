describe 'term conditions' do
  let!(:customer){ create(:customer) }
  let!(:term_condition){ create(:term_condition) }

  describe 'GET api/v1/customer/term_conditions/:id' do
    before do
      get api_v1_customer_term_conditions_path(term_condition), headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return term condition' do
      json = JSON.parse(response.body)
      expect(json.to_s).to include term_condition.body
    end
  end

end
