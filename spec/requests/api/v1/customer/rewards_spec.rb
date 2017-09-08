describe 'Reward' do
  let!(:customer){ create(:customer) }
  let!(:company){ create(:company, name: "Codingate", address: "btb") }
  let!(:reward1){ create(:reward, name: "google", require_points: 300, quantity: 6, company: company ) }
  let!(:reward2){ create(:reward, name: "facebook", require_points: 500, quantity: 2, approved_claimed_rewards_count: 2, company: company ) }


  describe 'GET api/v1/customer/rewards' do

    before do
      get api_v1_customer_rewards_path, headers: customer.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'include available reward' do
      json = JSON.parse(response.body)
      names = json.map{ |j| j['id'] }
      expect(names).to include reward1.id
    end

    it 'include unavailable reward' do
      json = JSON.parse(response.body)
      names = json.map{ |j| j['id'] }
      expect(names).not_to include reward2.id
    end
  end

end