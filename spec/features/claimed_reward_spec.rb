feature 'ClaimedReward' do
  given!(:customer) { create(:customer, current_points: 15, first_name: 'Code', last_name: 'Gate') }
  given!(:admin) { create(:user, name: 'test') }
  given!(:reward) { create(:reward, require_points: 14) }
  given!(:claimed_reward) { create(:claimed_reward, customer: customer, reward: reward ) }

  before do
    login_as admin, scope: :user
  end

  feature 'Listing' do
    scenario 'see all claimed_reward' do
      visit root_path
      click_link 'Claimed Rewards'
      expect(page).to have_content(claimed_reward.customer_name)
      expect(page).to have_content(claimed_reward.reward_name)
    end
  end

  feature 'Show' do
    scenario 'Show claimed_reward detail' do
      visit claimed_reward_path(claimed_reward)
      expect(page).to have_content(claimed_reward.status)
    end

    scenario 'Approve Successfully' do
      visit claimed_reward_path(claimed_reward)
      click_on 'Approve'

      expect(claimed_reward).to transition_from(:submitted).to(:approved).on_event(:approving)
      expect(page).to have_content 'Claimed Reward was successfully approved.'
    end

    scenario 'Descrease points from user' do
      visit claimed_reward_path(claimed_reward)
      click_on 'Approve'

      left_points = customer.current_points.to_i - reward.require_points.to_i
      customer.reload
      expect(customer).to have_attributes(current_points: left_points)
      expect(page).to have_content 'Claimed Reward was successfully approved.'
    end

    scenario 'Reject Successfully' do
      visit claimed_reward_path(claimed_reward)
      click_on 'Reject'

      expect(claimed_reward).to transition_from(:submitted).to(:rejected).on_event(:rejecting)
      expect(page).to have_content 'Claimed Reward was successfully rejected.'
    end

  end

  feature 'Destroy' do
    scenario 'Destroy Successfully' do
      visit claimed_reward_path(claimed_reward)
      click_link 'Delete'
      expect(page).to have_content 'Claimed Reward was successfully deleted.'
    end
  end

end
