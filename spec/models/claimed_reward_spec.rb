describe ClaimedReward, 'Validate' do
  context 'Reward in stock?' do
    let!(:customer) { create(:customer, current_points: 600) }
  
    let!(:reward1){create(:reward, require_points: 50, quantity: 2, approved_claimed_rewards_count: 0)}
    let!(:reward2){create(:reward, require_points: 300, quantity: 2, approved_claimed_rewards_count: 2)}
  

    it 'valid when reward available in stock' do
      claimed_reward = build(:claimed_reward, customer: customer, reward: reward1 )
      expect(claimed_reward).to be_valid
    end

    it 'invalid when reward not available in stock' do
      claimed_reward = build(:claimed_reward, customer: customer, reward: reward2 )
      expect(claimed_reward).to be_invalid
    end   
  end
end
