describe 'ClaimedRewards' do
  let!(:store){ create(:store, name: "Codingate") }
  let!(:merchant){ create(:merchant, store: store) }
  let!(:customer){ create(:customer, current_points: 10000) }
  let!(:reward)  { create(:reward, store: store) }

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

end
