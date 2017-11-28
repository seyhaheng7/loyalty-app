feature 'ClaimedReward' do
  given!(:customer) { create(:customer, current_points: 150, first_name: 'Code', last_name: 'Gate') }
  given!(:admin) { create(:user, name: 'test') }
  given!(:reward) { create(:reward, require_points: 14 ) }
  given!(:claimed_reward) { create(:claimed_reward, customer: customer, reward: reward ) }

  before do
    login_as admin, scope: :user
  end

  feature 'Listing' do
    scenario 'see all claimed_reward' do
      visit root_path
      click_link 'Reward Claim'
      expect(page).to have_content(claimed_reward.customer_name)
      expect(page).to have_content(claimed_reward.reward_name)
    end
  end

  feature 'Show' do
    scenario 'Show claimed_reward detail' do
      visit claimed_reward_path(claimed_reward)
      expect(page).to have_content(claimed_reward.customer.name)
    end
  end

end
