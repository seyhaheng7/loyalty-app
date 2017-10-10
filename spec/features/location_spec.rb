feature 'Location' do
  given!(:user)    { create(:user) }
  given!(:location){ create(:location) }
  before do
    login_as user, scope: :user
  end
  feature 'Listing' do
    scenario 'see all location' do
      visit root_path
      click_on "Location"
      expect(page).to have_content(location.name)
    end
  end

  feature 'Create' do
    scenario 'Create Successfully' do
      visit locations_path
      click_link 'New Location'
      fill_in 'Name', with: 'Beng Keng Kong'
      click_on 'Create Location'
      expect(page).to have_content 'Location was successfully created'
    end

    scenario 'Create Unsuccessful' do
      visit new_location_path
      click_on 'Create Location'
      expect(page).to have_content 'can\'t be blank'
    end
  end


  feature 'Update' do
    scenario 'Update Successfully' do
      visit locations_path
      find("a[href='#{edit_location_path(location)}']").click
      fill_in 'Name', with: 'Beng Keng Kong'
      click_on 'Update Location'
      expect(page).to have_content 'Location was successfully updated'
    end

    scenario 'Update Unsuccessful' do
      visit edit_location_path(location)
      fill_in 'Name', with: ''
      click_on 'Update Location'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Destroy' do
    scenario 'Destroy Successfully' do
      visit location_path(location)
      click_link 'Delete'
      expect(page).to have_content 'Location was successfully deleted.'
    end
  end
end
