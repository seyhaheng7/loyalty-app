describe 'Customer Login' do
  let!(:customer){ create(:customer) }

  it 'login successfully' do
    put send_digit_api_v1_customer_digits_path, params: { phone: customer.phone }
    expect(response.status).to eq(200)
    customer.reload
    post customer_session_path, params: { phone: customer.phone, digit: customer.login_digit }
    expect(response.status).to eq(200)
    expect(response.headers).to have_key('access-token')
    expect(response.headers).to have_key('token-type')
    expect(response.headers).to have_key('client')
    expect(response.headers).to have_key('expiry')
    expect(response.headers).to have_key('uid')
  end


  it 'will not send digit to incorrect phone number' do
    put send_digit_api_v1_customer_digits_path, params: { phone: '1834797' }
    expect(response.status).to eq(404)
  end



  it 'login unsuccessfully when incorrect digit' do
    put send_digit_api_v1_customer_digits_path, params: { phone: customer.phone }
    post customer_session_path, params: { phone: customer.phone, digit: 'asdfj' }
    expect(response.status).to eq(401)
  end
end
