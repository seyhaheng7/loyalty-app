feature 'Reward' do
  given!(:user)    { create(:user, name: 'test') }
  given!(:reward){ create(:reward) }
  given!(:store){create(:store, name: "KFC")}

  before do
    login_as user, scope: :user
  end

  feature 'Listing' do
    scenario 'see all reward' do
      visit root_path
      click_link 'Rewards', href: rewards_path
      expect(page).to have_content(reward.name)
    end
  end

  feature 'Create' do
    scenario 'Create Successfully' do
      visit rewards_path
      click_link 'Add New Reward'
      fill_in 'Name', with: 'Ipad'
      fill_in 'Require points', with: '1'
      fill_in 'Quantity', with: '10'
      fill_in 'Start date', with: Date.today
      fill_in 'End date', with: Date.today+5.days
      attach_file('reward[image]', File.join(Rails.root, 'spec/support/default.png'))
      select 'KFC', :from => 'Store'
      click_on 'Create Reward'
      expect(page).to have_content 'Reward was successfully created.'
    end

    scenario 'Create Unsuccessful' do
      visit new_reward_path
      click_on 'Create Reward'
      expect(page).to have_content 'Please review the problems below:'
    end
  end


  feature 'Update' do
    scenario 'Update Successfully' do
      visit rewards_path
      find("a[href='#{edit_reward_path(reward)}']").click
      fill_in 'Name', with: 'Coffee Shop'
      select 'KFC', :from => 'Store'
      click_on 'Update Reward'
      expect(page).to have_content 'Reward was successfully updated.'
    end

    scenario 'Update Unsuccessful' do
      visit edit_reward_path(reward)
      fill_in 'Name', with: ''
      click_on 'Update Reward'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Show' do
    scenario 'Show reward detail' do
      visit reward_path(reward)
      expect(page).to have_content(reward.name)
    end
  end

  feature 'Destroy' do
    scenario 'Destroy Successfully' do
      visit reward_path(reward)
      click_link 'Delete'
      expect(page).to have_content 'Reward was successfully deleted.'
    end
  end
end
