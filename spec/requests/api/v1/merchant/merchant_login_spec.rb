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
