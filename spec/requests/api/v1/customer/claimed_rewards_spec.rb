describe 'ClaimedRewards' do
  let!(:customer1){ create(:customer) }
  let!(:customer2){ create(:customer, current_points: 0) }
  let!(:reward){ create(:reward, require_points: 50) }

  let!(:claimed_reward1){create(:claimed_reward, status:'approved', customer_id: customer1.id, reward_id: reward.id )}
  let!(:claimed_reward2){create(:claimed_reward, status:'rejected' )}
  let!(:claimed_reward3){create(:claimed_reward, status:'submitted' )}


  describe 'Get api/v1/customer/claimed_rewards' do

    it 'return status approved' do
      get api_v1_customer_claimed_rewards_path, headers: customer1.create_new_auth_token
      claimed_reward = ClaimedReward.last
      expect(claimed_reward1).to have_attributes(status: 'approved')
    end

    it 'return status rejected' do
      get api_v1_customer_claimed_rewards_path, headers: customer1.create_new_auth_token
      claimed_reward = ClaimedReward.last
      expect(claimed_reward2).to have_attributes(status: 'rejected')
    end

    it 'return status submmited' do
      get api_v1_customer_claimed_rewards_path, headers: customer1.create_new_auth_token
      claimed_reward = ClaimedReward.last
      expect(claimed_reward3).to have_attributes(status: 'submitted')
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
      claimed_reward = ClaimedReward.last
      expect(claimed_reward).to have_attributes(status: 'submitted')
    end


    it "errors when have user doesn't have enough points" do
      post api_v1_customer_claimed_rewards_path, headers: customer2.create_new_auth_token, params: { claimed_reward: params2 }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(json["errors"]["customer_points"]).to include "Customer doesn't have enough points"
    end
  end

 

end
