describe 'Customer Login' do
  let!(:customer){ create(:customer) }

  it 'login successfully' do
    put send_digit_api_v1_customer_digits_path, params: { phone: customer.phone }
    expect(response.status).to eq(200)
    customer.reload
    post customer_session_path, params: { phone: customer.phone, digit: customer.login_digit, device_id: 'abc' }
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


describe 'Customer Logout' do
  let!(:customer){ create(:customer) }

  it 'logout successfully' do
    put send_digit_api_v1_customer_digits_path, params: { phone: customer.phone }
    customer.reload
    post customer_session_path, params: { phone: customer.phone, digit: customer.login_digit, device_id: 'abc123' }
    expect(customer.devices.count).to eq 1

    access_token = response.headers['access-token']
    token_type   = response.headers['token-type']
    client       = response.headers['client']
    expiry       = response.headers['expiry']
    uid          = response.headers['uid']

    params = {
      'access-token' => access_token,
      'token-type' => token_type,
      'client' => client,
      'expiry' => expiry,
      'uid' => uid,
      'device_id' => 'abc123'
    }

    delete destroy_customer_session_path, params: params
    expect(response.status).to eq(200)
    expect(customer.devices.count).to eq 0
  end
end


describe 'Customer Update' do
  let!(:customer){ create(:customer) }

  it 'update successfully' do
    params = {
      first_name: 'Abc',
      last_name: 'Def',
    }
    patch customer_registration_path, headers: customer.create_new_auth_token, params: params

    expect(response.status).to eq(200)
  end
end
