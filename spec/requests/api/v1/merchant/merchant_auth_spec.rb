describe 'Merchant Login' do
  let!(:merchant){ create(:merchant, password: 'abc123', password_confirmation: 'abc123') }

  it 'login successfully' do
    post merchant_session_path, params: { phone: merchant.phone, password: 'abc123' }
    expect(response.status).to eq(200)
    expect(response.headers).to have_key('access-token')
    expect(response.headers).to have_key('token-type')
    expect(response.headers).to have_key('client')
    expect(response.headers).to have_key('expiry')
    expect(response.headers).to have_key('uid')
  end

  it 'login unsuccessfully' do
    post merchant_session_path, params: { phone: merchant.phone, password: 'adsfa' }
    expect(response.status).to eq(401)
  end
end

describe 'Merchant Logout' do
  let!(:merchant){ create(:merchant, password: 'abc123', password_confirmation: 'abc123') }

  it 'logout successfully' do
    post merchant_session_path, params: { phone: merchant.phone, password: 'abc123', device_id: 'abc123' }
    expect(merchant.devices.count).to eq 1

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

    delete destroy_merchant_session_path, params: params
    expect(response.status).to eq(200)
    expect(merchant.devices.count).to eq 0
  end
end
