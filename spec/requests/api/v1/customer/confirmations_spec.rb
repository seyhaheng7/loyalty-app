describe 'Confirmation' do
  let!(:customer){ create(:customer, :unverified) }

  it 'confirm success' do
    put confirm_api_v1_customer_confirmations_path, params: { phone: customer.phone, verification_code: customer.verification_code }
    customer.reload
    expect(response).to have_http_status(200)
    expect(customer.verified?).to be_truthy
  end

  it 'confirm unsuccess' do
    put confirm_api_v1_customer_confirmations_path, params: { phone: customer.phone, verification_code: 'adsf' }
    customer.reload
    expect(response).to have_http_status(422)
    expect(customer.verified?).to be_falsy
  end
end
