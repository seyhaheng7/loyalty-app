describe 'ContactForms' do
  let!(:customer){ create(:customer) }

  describe 'POST api/v1/customer/contact_forms' do

    let!(:params1){ { subject: 'Not Response!', message: 'Not response after log out!' } }
    let!(:params2){ { subject: 'Not Response!' } }

    it 'return status successful' do
      post api_v1_customer_contact_forms_path, headers: customer.create_new_auth_token, params: { contact_form: params1 }
      expect(response).to have_http_status(201)
    end

    it "errors when missing message params" do
      post api_v1_customer_contact_forms_path, headers: customer.create_new_auth_token, params: { contact_form: params2 }
      expect(response).to have_http_status(422)
    end

  end
end