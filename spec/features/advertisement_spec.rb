feature 'Advertisement' do
  given!(:user)    { create(:user) }
  given!(:advertisement){ create(:advertisement) }

  before do
    login_as user, scope: :user
  end

  feature 'Listing' do
    scenario 'see all advertisement' do
      visit root_path
      click_link 'Advertisements'
      expect(page).to have_content(advertisement.name)
    end
  end

  feature 'Create' do
    scenario 'Create Successfully' do
      visit advertisements_path
      click_link 'New Advertisement'
      fill_in 'Name', with: 'Coffee Shop'
      attach_file('advertisement[banner]', File.join(Rails.root, 'spec/support/default.png'))
      click_on 'Create Advertisement'
      expect(page).to have_content 'Advertisement was successfully created'
    end

    scenario 'Create Unsuccessful' do
      visit new_advertisement_path
      click_on 'Create Advertisement'
      expect(page).to have_content 'can\'t be blank'
    end
  end


  feature 'Update' do
    scenario 'Update Successfully' do
      visit advertisements_path
      find("a[href='#{edit_advertisement_path(advertisement)}']").click
      fill_in 'Name', with: 'Coffee Shop'
      click_on 'Update Advertisement'
      expect(page).to have_content 'Advertisement was successfully updated'
    end

    scenario 'Update Unsuccessful' do
      visit edit_advertisement_path(advertisement)
      fill_in 'Name', with: ''
      click_on 'Update Advertisement'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Show' do
    scenario 'Show advertisement detail' do
      visit advertisement_path(advertisement)
      expect(page).to have_content(advertisement.name)
    end
  end

  feature 'Destroy' do
    scenario 'Destroy Successfully' do
      visit advertisements_path
      click_link 'Delete'
      expect(page).to have_content 'Advertisement was successfully deleted.'
    end
  end

end