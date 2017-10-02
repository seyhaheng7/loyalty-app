
describe 'ClaimedRewards' do
  let!(:store){ create(:store, name: "Codingate") }
  let!(:merchant){ create(:merchant, store: store) }
  let!(:customer){ create(:customer, current_points: 10000) }
  let!(:reward1){ create(:reward, name: "google", require_points: 300, quantity: 6, store: store ) }
  let!(:reward)  { create(:reward, store: store) }
  let!(:claimed_reward1){ create(:claimed_reward, status: "approved", reward: reward1 ) }


  context 'GET api/v1/merchant/claimed_rewards' do
    let!(:merchant1){ create(:merchant) }
    let!(:reward2){ create(:reward, name: "google", require_points: 300, quantity: 6, store: merchant1.store ) }
    let!(:claimed_reward1){ create(:claimed_reward, :approved, reward: reward1 ) }
    let!(:claimed_reward2){ create(:claimed_reward, :rejected, reward: reward1 ) }
    let!(:claimed_reward3){ create(:claimed_reward, :submitted, reward: reward1 ) }
    let!(:claimed_reward4){ create(:claimed_reward, :approved, reward: reward2 ) }


    before do
      get api_v1_merchant_claimed_rewards_path, headers: merchant.create_new_auth_token
    end

    it 'return status successful' do
      expect(response).to have_http_status(200)
    end

    it 'list of approved claimed_reward for merchant' do
      json  = JSON.parse(response.body)
      ids   = json.map{ |j| j['id'] }
      expect(ids).to include claimed_reward1.id
    end


    it 'not list rejected or submitted claimed_reward' do
      json  = JSON.parse(response.body)
      ids   = json.map{ |j| j['id'] }
      expect(ids).not_to include claimed_reward2.id
      expect(ids).not_to include claimed_reward3.id
    end

    it 'not list of approved claimed_reward of other merchant' do
      json  = JSON.parse(response.body)
      ids   = json.map{ |j| j['id'] }
      expect(ids).not_to include claimed_reward4.id
    end
  end


  describe 'Patch api/v1/merchant/claimed_rewards/given' do

    let!(:claimed_reward1){create(:claimed_reward, status: 'approved', reward: reward, qr_token: 'fdkewidsjfwe3', customer: customer )}
    let!(:claimed_reward2){create(:claimed_reward, status: 'approved', reward: reward, qr_token: 'fdkewidsjfwe1', customer: customer )}
    let!(:claimed_reward3){create(:claimed_reward, status: 'approved', reward: reward, qr_token: 'fdkewidsjfw5', customer: customer )}
    let!(:claimed_reward4){create(:claimed_reward, status: 'approved', reward: reward, qr_token: 'fdkewidsjfwedsaf', customer: customer )}

    it 'return status not found' do
      put given_api_v1_merchant_claimed_rewards_path(qr_token: 'fdkewidsjfwe' ), headers: merchant.create_new_auth_token
      expect(response).to have_http_status(404)
    end

    it 'update given to true' do
      put given_api_v1_merchant_claimed_rewards_path(qr_token: 'fdkewidsjfw5' ), headers: merchant.create_new_auth_token
      claimed_reward3.reload
      expect(claimed_reward3.given).to be true
    end
  end

  context 'GET api/v1/merchant/claimed_rewards?given=true' do
    let!(:given_claimed_reward)    { create(:claimed_reward, :approved, given: true, reward: reward1 ) }
    let!(:not_given_claimed_reward){ create(:claimed_reward, :approved, reward: reward1 ) }

    before do
      get api_v1_merchant_claimed_rewards_path(given: 'true'), headers: merchant.create_new_auth_token
    end

    it 'list of claimed_reward that already given' do
      json  = JSON.parse(response.body)
      ids   = json.map{ |j| j['id'] }
      expect(ids).to include given_claimed_reward.id
    end

    it 'not list claimed_reward that not yet given' do
      json  = JSON.parse(response.body)
      ids   = json.map{ |j| j['id'] }
      expect(ids).not_to include not_given_claimed_reward.id
    end
  end


  context 'GET api/v1/merchant/claimed_rewards?given=false' do
    let!(:given_claimed_reward)    { create(:claimed_reward, :approved, given: true, reward: reward1 ) }
    let!(:not_given_claimed_reward){ create(:claimed_reward, :approved, reward: reward1 ) }

    before do
      get api_v1_merchant_claimed_rewards_path(given: 'false'), headers: merchant.create_new_auth_token
    end

    it 'list of claimed_reward that already given' do
      json  = JSON.parse(response.body)
      ids   = json.map{ |j| j['id'] }
      expect(ids).to include not_given_claimed_reward.id
    end

    it 'not list claimed_reward that not yet given' do
      json  = JSON.parse(response.body)
      ids   = json.map{ |j| j['id'] }
      expect(ids).not_to include given_claimed_reward.id
    end
  end

end
