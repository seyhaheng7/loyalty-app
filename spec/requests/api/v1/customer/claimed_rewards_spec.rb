describe 'ClaimedRewards' do
  let!(:customer1){ create(:customer) }
  let!(:customer2){ create(:customer, current_points: 0) }
  let!(:reward){ create(:reward, require_points: 50, claimed_reward_expired: 3, start_date: Date.today - 15, end_date: Date.today - 10 ) }
  let!(:claimed_reward1){create(:claimed_reward, customer_id: customer1.id, reward_id: reward.id, expired_at: Date.today )}
  let!(:claimed_reward2){create(:claimed_reward)}
  let!(:claimed_reward3){create(:claimed_reward)}


  describe 'Get api/v1/customer/claimed_rewards' do
    let!(:params1){ { reward_id: reward.id } }

    it 'return status successful' do
      post api_v1_customer_claimed_rewards_path, headers: customer1.create_new_auth_token, params: { claimed_reward: params1 }
      expect(response).to have_http_status(201)
    end
  end

  describe 'POST api/v1/customer/claimed_rewards' do

    let!(:params1){ { reward_id: reward.id } }
    let!(:params2){ { reward_id: reward.id } }

    it 'return status successful' do
      post api_v1_customer_claimed_rewards_path, headers: customer1.create_new_auth_token, params: { claimed_reward: params1 }
      expect(response).to have_http_status(201)
    end

    it 'has claimed_reward status submitted' do
      post api_v1_customer_claimed_rewards_path, headers: customer1.create_new_auth_token, params: { claimed_reward: params1 }
      json = JSON.parse(response.body)
      claimed_reward_status = json["status"]
      expect(claimed_reward_status).to eq "submitted"
    end


    it "errors when have user doesn't have enough points" do
      post api_v1_customer_claimed_rewards_path, headers: customer2.create_new_auth_token, params: { claimed_reward: params2 }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(json["errors"]["customer_points"]).to include "Customer doesn't have enough points"
    end

    it 'Generate QR Token after create' do
      post api_v1_customer_claimed_rewards_path, headers: customer1.create_new_auth_token, params: { claimed_reward: params1 }
      claimed_reward = ClaimedReward.last
      expect(claimed_reward.qr_token).not_to be_nil
    end

    it 'Descrease points from customer' do
      customer1.reload
      left_points     = customer1.current_points.to_i - reward.require_points.to_i
      post api_v1_customer_claimed_rewards_path, headers: customer1.create_new_auth_token, params: { claimed_reward: params1 }
      claimed_reward  = ClaimedReward.last
      customer        = claimed_reward.customer
      reward          = claimed_reward.reward
      customer1.reload
      expect(customer1).to have_attributes(current_points: left_points)
    end

  end
end
