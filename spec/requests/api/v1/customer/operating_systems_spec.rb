describe 'OperatingSystem' do
  let!(:customer){ create(:customer) }
  let!(:fields){ {name: "andorid" }}

  describe 'POST api/v1/customer/operating_systems' do
    it 'return status successful' do
      post api_v1_customer_operating_systems_path, headers: customer.create_new_auth_token, params: { operating_system: fields }
      expect(response).to have_http_status(200)
    end

  end
end
