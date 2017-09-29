describe 'privacy policies' do
  let!(:customer){ create(:customer) }
  let!(:privacy_policy){ create(:privacy_policy) }

  describe 'GET api/v1/customer/privacy_policies/:id' do
    before do
      get api_v1_customer_privacy_policies_path(privacy_policy), headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'return privacy_policy' do
      json = JSON.parse(response.body)
      expect(json.to_s).to include privacy_policy.body
    end
  end

end
