describe 'ClaimedRewards' do
  let!(:user1){ create(:user, current_points: 100) }
  let!(:user2){ create(:user, current_points: 0) }
  let!(:reward){ create(:reward, require_points: 50) }

  describe 'POST api/v1/customer/claimed_rewards' do

    let!(:params1){ { status: 'submitted', user_id: user1.id, reward_id: reward.id } }
    let!(:params2){ { status: 'submitted', user_id: user2.id, reward_id: reward.id } }

    it 'return status successful' do
      post api_v1_customer_claimed_rewards_path, headers: user1.create_new_auth_token, params: { claimed_reward: params1 } 
      expect(response).to have_http_status(201)
    end

    it "errors when have user doesn't have enough points" do
      post api_v1_customer_claimed_rewards_path, headers: user2.create_new_auth_token, params: { claimed_reward: params2 } 
      json = JSON.parse(response.body)
      expect(response).to have_http_status(422)  
      expect(json["errors"]["user_points"]).to include "User doesn't have enough points"
    end
    
  end

end